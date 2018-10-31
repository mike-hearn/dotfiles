#!/usr/bin/env bash

commands="$@"
projectname=$(basename `git rev-parse --show-toplevel`)

dirtonum() {
	echo $(basename $(git rev-parse --show-toplevel) | md5sum | sed 's/[a-f]//g' | cut -c1-3)
}

docker kill "$projectname" > /dev/null
docker run \
    --cap-add=SYS_ADMIN \
    --expose=${RUN_IN_DOCKER_PORT:-4200} \
    --health-cmd="curl -f http://localhost:${RUN_IN_DOCKER_PORT:-4200}" \
    --health-interval=3s \
    --interactive \
    --name="$projectname" \
    --network=traefik_default \
    --publish="3$(dirtonum):${RUN_IN_DOCKER_PORT:-4200}" \
    --publish="4$(dirtonum):${RUN_IN_DOCKER_PORT:-4200}" \
    --publish="8$(dirtonum):${RUN_IN_DOCKER_PORT:-4200}" \
    --publish="49$(dirtonum):49155" \
    --publish="7$(dirtonum):7357" \
    --rm \
    --tty \
    --volume $(pwd)/../:$(pwd)/../ \
    --volume $HOME/.config/yarn/:$HOME/.config/yarn \
    --workdir=$(pwd) \
    fedora-node-8 \
    $commands
