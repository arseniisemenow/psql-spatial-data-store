fix-docker:
	sed -ie 's/credsStore/credStore/g' ~/.docker/config.json

run-postgres:
	cd docker-folder && docker compose up -d
stop-postgres:
	cd docker-folder && docker compose down