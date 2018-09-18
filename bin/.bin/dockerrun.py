#!/usr/bin/env python3

from subprocess import call

command = """docker run \
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
    --workdir=$(pwd) \
    fedora-node-8 \
    $commands
"""

if __name__ == "__main__":
    print(command.split(' '))
