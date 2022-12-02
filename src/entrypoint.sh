#!/bin/sh

log() {
	printf "\n$(date +%Y-%m-%dT%H:%M:%S%z) | %s\n" "${1}"
}

log_sub() {
	printf "                         | %s\n" "${1}"
}

log "xjokay/loxone-backup ${VERSION}"

mkdir -p "/data/current" "/data/archives"

if [ -z "${LOXONE_IP}" ] || [ -z "${LOXONE_USERNAME}" ] || [ -z "${LOXONE_PASSWORD}" ]; then
	log "Required environment variables are missing!"
	log_sub "Please specify LOXONE_IP, LOXONE_USERNAME and LOXONE_PASSWORD."
	exit 1
fi

while :; do
	cd "/data" || exit

	log "Backup files from Loxone (${LOXONE_IP}) ..."
	lftp "${LOXONE_IP}" -u "${LOXONE_USERNAME},${LOXONE_PASSWORD}" -e "set ssl:verify-certificate false; mirror -a --parallel=5 --use-pget-n=1 --skip-noaccess --only-newer --log=ftp.log --use-cache . current; quit"
	tar -czf "archives/$(date +%Y-%m-%dT%H-%M-%S).tar.gz" "current/"

	if [ "${KEEP_DAYS}" -gt 0 ]; then
		cd "/data/archives" || exit

		log "Cleanup backups older than ${KEEP_DAYS} day(s) ..."
		find . -mtime "+${KEEP_DAYS}" -print0 | xargs --no-run-if-empty rm
	fi

	next=$(date -d "@$(($(date +%s) + INTERVAL))" +%Y-%m-%dT%H:%M:%S%z)
	log "Next run on ${next} ..."

	sleep "${INTERVAL}"
done
