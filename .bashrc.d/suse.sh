function devenv() {
	if [[ $1 == "up" ]]; then
		docker compose -f /home/jonas/Projects/suse/dev-infra/docker-compose.yml up -d
	fi
	
	if [[ $1 == "down" ]]; then
		docker compose -f /home/jonas/Projects/suse/dev-infra/docker-compose.yml down
	fi

	if [[ -z $1 ]]; then
		docker compose -f /home/jonas/Projects/suse/dev-infra/docker-compose.yml ps --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}"
	fi
}
