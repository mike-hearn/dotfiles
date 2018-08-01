#!/usr/bin/env bash

commands="$@"
projectname=$(basename `git rev-parse --show-toplevel`)

dirtonum() {
	echo $(basename $(git rev-parse --show-toplevel) | md5sum | sed 's/[a-f]//g' | cut -c1-3)
}

docker run \
    --cap-add=SYS_ADMIN \
    --expose=4200 \
    --health-cmd="curl -f http://localhost:4200" \
    --health-interval=3s \
    --interactive \
    --name="$projectname" \
    --network=traefik_default \
    --publish="4$(dirtonum):4200" \
    --publish="49$(dirtonum):49155" \
    --publish="7$(dirtonum):7357" \
    --rm \
    --tty \
    --volume $(pwd)/../:$(pwd)/../ \
    --workdir=$(pwd) \
    fedora-node-8 \
    $commands
