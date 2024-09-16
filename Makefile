run: build
	- docker run -it --rm \
	-p9898:9000 \
	--mount type=bind,source=.,target=/usr/src/app \
	--name laracast laracast

build:
	- docker build -t laracast -f Dockerfile .

exec:
	- docker exec -it laracast /bin/bash

bash:
	- docker exec -it laracast /bin/bash