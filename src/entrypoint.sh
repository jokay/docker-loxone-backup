#!/bin/sh

log() {
  printf "\n$(date +%Y-%m-%dT%H:%M:%S%z) | %s\n" "${1}"
}

log_sub() {
  printf "                         | %s\n" "${1}"
}

# Check required params
check() {
  if [ -z "${LOXONE_IP}" ] || [ -z "${LOXONE_USERNAME}" ] || [ -z "${LOXONE_PASSWORD}" ]; then
    log "Required environment variables are missing!"
    log_sub "Please specify LOXONE_IP, LOXONE_USERNAME and LOXONE_PASSWORD."
    exit 1
  fi
}

# Show configuration
config() {
  log "Configuration"
  log_sub ""
  log_sub "INTERVAL: ${INTERVAL}"
  log_sub "KEEP_DAYS: ${KEEP_DAYS}"
  log_sub "VERBOSE: ${VERBOSE}"
  log_sub "EXCLUDE_DIRS: ${EXCLUDE_DIRS}"
}

# Setup file structure
setup() {
  mkdir -p "/data/current" "/data/archives"
}

# Compose FTP params
ftp_params() {
  FTP_PARAMS="-a -n -e -P=5 --use-pget-n=1 --skip-noaccess --use-cache --log=ftp.log"

  if [ "${VERBOSE}" = "true" ]; then
    FTP_PARAMS="${FTP_PARAMS} -vvv"
  fi

  if [ -n "${EXCLUDE_DIRS}" ]; then
    for EXCLUDE_DIR in $(printf "%s" "${EXCLUDE_DIRS}" | sed 's/,/ /g'); do
      rm -rf "/data/current/${EXCLUDE_DIR}"
      FTP_PARAMS="${FTP_PARAMS} -x '${EXCLUDE_DIR}/'"
    done
  fi
}

# Backup and compress files
backup() {
  log "Backup files from Loxone (${LOXONE_IP}) ..."
  lftp "${LOXONE_IP}" -u "${LOXONE_USERNAME},${LOXONE_PASSWORD}" -e "set ssl:verify-certificate false; mirror ${FTP_PARAMS} . current; quit"
  tar -czf "archives/loxone_backup_${LOXONE_IP}_$(date +%Y-%m-%d_%H-%M-%S).tar.gz" "current/"
}

# Cleanup old archives
cleanup() {
  if [ "${KEEP_DAYS}" -gt 0 ]; then
    cd "/data/archives" || exit

    log "Cleanup backups older than ${KEEP_DAYS} day(s) ..."
    find . -mtime "+${KEEP_DAYS}" -print0 | xargs --no-run-if-empty rm
  fi
}

log "xjokay/loxone-backup ${VERSION}"

check

config

setup

ftp_params

while :; do
  cd "/data" || exit

  backup

  cleanup

  next=$(date -d "@$(($(date +%s) + INTERVAL))" +%Y-%m-%dT%H:%M:%S%z)
  log "Next run on ${next} ..."

  sleep "${INTERVAL}"
done
