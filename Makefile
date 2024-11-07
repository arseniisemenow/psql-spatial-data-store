

run-postgres:
	cd docker-folder && docker compose up -d
stop-postgres:
	cd docker-folder && docker compose down

run-development:
	cd docker-folder/docker-dev && docker compose up -d
stop-development:
	cd docker-folder/docker-dev && docker compose down


# Attention! use this if you understand what you do. Do
fix-docker:
	sed -ie 's/credsStore/credStore/g' ~/.docker/config.json
fix-sshd:
	echo "Host *" >> ~/.ssh/config
	echo "ServerAliveInterval 30" >> ~/.ssh/config
	echo "ServerAliveCountMax 6" >> ~/.ssh/config
