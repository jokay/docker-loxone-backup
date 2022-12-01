#!/bin/sh

log() {
	printf "\n$(date -u +%Y-%m-%dT%H:%M:%S%z) | %s\n" "${1}"
}

log "xjokay/loxone-backup ${VERSION}"

mkdir -p "/data/current" "/data/archives"

while :; do
	cd "/data" || exit

	log "Get files from Miniserver ..."
	lftp "${LOXONE_IP}" -u "${LOXONE_USERNAME},${LOXONE_PASSWORD}" -e "set ssl:verify-certificate false; mirror -a --parallel=5 --use-pget-n=1 --skip-noaccess --only-newer --log=ftp.log --use-cache . current; quit"

	log "Compress files ..."
	tar czf "archives/loxone-backup-$(date +%Y-%m-%dT%H-%M-%S).tar.gz" "current/"

	log "Cleanup old backups ..."
	cd "/data/archives" || exit
	ls -tr | head -n -${BACKUP_LIMIT} | xargs --no-run-if-empty rm
	
	next=$(date -u -d "@$(($(date +%s) + INTERVAL))" +%Y-%m-%dT%H:%M:%S%z)
	log "Next run on ${next} ..."

	sleep "${INTERVAL}"
done
