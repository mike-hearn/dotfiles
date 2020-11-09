#!/usr/bin/env bash

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$_"
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
    cd $(dirname $@)
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
    local tmpFile="${@%/}.tar"
    tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

    size=$(
        stat -f"%z" "${tmpFile}" 2>/dev/null # macOS `stat`
        stat -c"%s" "${tmpFile}" 2>/dev/null # GNU `stat`
    )

    local cmd=""
    if ((size < 52428800)) && hash zopfli 2>/dev/null; then
        # the .tar file is smaller than 50 MB and Zopfli is available; use it
        cmd="zopfli"
    else
        if hash pigz 2>/dev/null; then
            cmd="pigz"
        else
            cmd="gzip"
        fi
    fi

    echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…"
    "${cmd}" -v "${tmpFile}" || return 1
    [ -f "${tmpFile}" ] && rm "${tmpFile}"

    zippedSize=$(
        stat -f"%z" "${tmpFile}.gz" 2>/dev/null # macOS `stat`
        stat -c"%s" "${tmpFile}.gz" 2>/dev/null # GNU `stat`
    )

    echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully."
}

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null >/dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg .[^.]* ./*
    fi
}

# Use Git’s colored diff when available
hash git &>/dev/null
if [ $? -eq 0 ]; then
    function diff() {
        git diff --no-index --color-words "$@"
    }
fi

# Create a data URL from a file
function dataurl() {
    local mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Create a git.io short URL
function gitio() {
    if [ -z "${1}" -o -z "${2}" ]; then
        echo "Usage: \`gitio slug url\`"
        return 1
    fi
    curl -i https://git.io/ -F "url=${2}" -F "code=${1}"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    sleep 1 && open "http://localhost:${port}/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
    local port="${1:-4000}"
    local ip=$(ipconfig getifaddr en1)
    sleep 1 && open "http://${ip}:${port}/" &
    php -S "${ip}:${port}"
}

# Compare original and gzipped file size
function gz() {
    local origsize=$(wc -c <"$1")
    local gzipsize=$(gzip -c "$1" | wc -c)
    local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)
    printf "orig: %d bytes\n" "$origsize"
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
    if [ -t 0 ]; then # argument
        python -mjson.tool <<<"$*" | pygmentize -l javascript
    else # pipe
        python -mjson.tool | pygmentize -l javascript
    fi
}

# Run `dig` and display the most useful info
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

# UTF-8-encode a string of Unicode symbols
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo "" # newline
    fi
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo "" # newline
    fi
}

# Get a character’s Unicode code point
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo "" # newline
    fi
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified."
        return 1
    fi

    local domain="${1}"
    echo "Testing ${domain}…"
    echo "" # newline

    local tmp=$(echo -e "GET / HTTP/1.0\nEOT" |
        openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1)

    if [[ "${tmp}" == *"-----BEGIN CERTIFICATE-----"* ]]; then
        local certText=$(echo "${tmp}" |
            openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
            no_serial, no_sigdump, no_signame, no_validity, no_version")
        echo "Common Name:"
        echo "" # newline
        echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//"
        echo "" # newline
        echo "Subject Alternative Name(s):"
        echo "" # newline
        echo "${certText}" | grep -A 1 "Subject Alternative Name:" |
            sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
        return 0
    else
        echo "ERROR: Certificate not found."
        return 1
    fi
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
function s() {
    if [ $# -eq 0 ]; then
        subl .
    else
        subl "$@"
    fi
}

# `a` with no arguments opens the current directory in Atom Editor, otherwise
# opens the given location
function a() {
    if [ $# -eq 0 ]; then
        atom .
    else
        atom "$@"
    fi
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v() {
    if [ $# -eq 0 ]; then
        vim .
    else
        vim "$@"
    fi
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
    if [ $# -eq 0 ]; then
        open .
    else
        open "$@"
    fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX
}

# ----------------------------------------------------------------------
#  Docker container service/util aliases
# ----------------------------------------------------------------------
# function tldr { docker run --rm mikehearn/tldr $@; }
# function hugo { docker run --rm -v $(pwd):/data mikehearn/hugo $@; }
function gcloud() {
    mkdir -p $HOME/.config/gcloud
    docker run --rm -ti -v $HOME/.config/gcloud:/home/gcloud/.config/gcloud mikehearn/gcloud $@
}

# ----------------------------------------------------------------------
#  ffmpeg
# ----------------------------------------------------------------------

# Split MP4 files
function ffsplit() { ffmpeg -i "$1" -f segment -segment_time 0.001 -vcodec copy -an -sn -y -reset_timestamps 1 -map 0 "$1.%04d.mp4"; }

# Use ffmpeg to create a GIF
palette="/tmp/palette.png"
filters="scale=${2-400}:-1:flags=lanczos"
gifsize="400"
function Ffmpeggif() {
    ffmpeg -v warning -i "$1" -vf "$filters,palettegen" -y $palette
    ffmpeg -v warning -i "$1" -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y "$1.gif"
}
function Ffmpeggif2() {
    echo "Creating gif..."
    ffmpeg -i "$1" -filter_complex "[0:v]scale=${2-$gifsize}:-2:flags=bicubic[bg];[bg]split[vid][pal];[pal]palettegen[pal];[vid][pal]paletteuse" -y "$1.gif"
    echo "Creating compressed/lossy GIF via gifsicle..."
    gifsicle "$1.gif" --lossy -o "$1.lossy.gif"
    echo "Done."
}

# Convert file to WebM
function toWebM() { ffmpeg -i "$1" -c:v libvpx -crf 10 -b:v 20M -c:a libvorbis "$1.$(date +%H%M%S%d%m%y).webm"; }

# Convert file to MP4
function toMP4() { ffmpeg -i "$1" -crf 17 -vf "scale=trunc(in_w/2)*2:trunc(in_h/2)*2" -pix_fmt yuv420p "$1.$(date +%H%M%S%d%m%y).mp4"; }

# All keyframes
function allkeyframes() { ffmpeg -i "$1" -crf 18 -x264-params keyint=1 -pix_fmt yuv420p -y "$1.$(date +%H%M%S%d%m%y).allkeyframes.mp4"; }

# Convert video into smooth 60fps... OR 24fps
function smooth() { vspipe --arg in_filename="$1" --arg display_fps=60 --y4m ~/.mpv/60fps.py - | ffmpeg -i - -crf 17 -y "$1.$(date +%H%M%S%d%m%y).60fps.mp4"; }
function to24fps() { vspipe --arg in_filename="$1" --arg display_fps=24 --y4m ~/.mpv/60fps.py - | ffmpeg -i - -crf 17 -y "$1.$(date +%H%M%S%d%m%y).24fps.mp4"; }

function stable() {
    ffmpeg -i "$1" -vf vidstabdetect=stepsize=12:result=transform_vectors.trf -f null -
    ffmpeg -i "$1" -vf vidstabtransform=input=transform_vectors.trf:zoom=1:smoothing=30,unsharp=5:5:0.8:3:3:0.4 -vcodec libx264 -preset slow -tune film -crf 18 -acodec copy "$1.stable.mp4"
}

function deshake() {
    ffmpeg -i "$1" -vf vidstabdetect=shakiness=10:accuracy=15:result="/tmp/mytransforms.trf" -f null -
    ffmpeg -i "$1" -vf vidstabtransform=zoom=15:smoothing=30:input="/tmp/mytransforms.trf",unsharp=5:5:0.8:3:3:0.4 -crf 16 -y "$1.deshake.mp4"
}

function decimate() {
    ffmpeg -i "$1" -vf mpdecimate=hi=64*24 -an -vsync 2 -crf 16 -y "$1.decimated.mp4"
}

# Quick find
function f() {
    rg --files --hidden 2>/dev/null | rg "$@"
}

# cd to directory, or if file, to containing dir
function cf() {
    if [[ -e $1 ]]; then
        if [[ -d $1 ]]; then
            cd $1
        else
            cd $(dirname $1)
        fi
    fi
}

# Re-attach to SSH Agent
function sagent() {
    [ -S "$SSH_AUTH_SOCK" ] || export SSH_AUTH_SOCK="$(<~/.ssh/ssh-agent.env)"

    # if cached agent socket is invalid, start a new one
    [ -S "$SSH_AUTH_SOCK" ] || {
        eval "$(ssh-agent)"
        ssh-add -t 25920000 -K ~/.ssh/id_rsa
        echo "$SSH_AUTH_SOCK" >~/.ssh/ssh-agent.env
    }
}

# cd to top of git repo
function cdg() {
    cd $(git rev-parse --show-toplevel)
}

# Actviate virtualenv from anywhere in repo (only works when named 'venv')
function vactivate() {
    source $(git rev-parse --show-toplevel)/venv/bin/activate 2>/dev/null
    source $(git rev-parse --show-toplevel)/.venv/bin/activate 2>/dev/null
}

tn() {
    local GITROOT=$(git rev-parse --show-toplevel 2>/dev/null)
    tmux rename-session -t "$(tmux display-message -p '#{session_name}')" "$(basename ${GITROOT:-$(basename $(pwd))} | sed 's/[-_\. ]/-/g')"
}

gri() {
    git stash save --include-untracked
    git rebase -i $1
    git stash pop
}

mkvirtualenv() {
    if [ $# -eq 0 ]; then
        python3 -m venv ~/.local/share/virtualenvs/$(basename $(pwd))
        workon $(basename $(pwd))
    else
        python3 -m venv ~/.local/share/virtualenvs/$@
        workon $@
    fi
}

workon() {
    if [ $# -eq 0 ]; then
        source ~/.local/share/virtualenvs/$(basename $(pwd))/bin/activate
    else
        source ~/.local/share/virtualenvs/$@/bin/activate
    fi
}

concatt() {
    rm /tmp/concatfiles.txt 2>/dev/null
    for var in "$@"; do
        echo file \'$var\' >>/tmp/concatfiles.txt
    done
    ffmpeg -f concat -safe 0 -i /tmp/concatfiles.txt -c copy -y "$1.concat.mp4"
    rm /tmp/concatfiles.txt 2>/dev/null
}

gitdir() {
    git rev-parse --show-toplevel
}

basegitdir() {
    basename $(git rev-parse --show-toplevel)
}

codesearch() {
    rg \
        --no-line-number \
        --no-filename \
        --color=never \
        "$1" |
        grep -v Omitted |
        sort -f |
        uniq -c |
        sort -k 1nr -k 2f |
        head -n ${2:-10}
}

deactivate () {
    if [ -n "${_OLD_VIRTUAL_PATH:-}" ]
    then
        PATH="${_OLD_VIRTUAL_PATH:-}"
        export PATH
        unset _OLD_VIRTUAL_PATH
    fi
    if [ -n "${_OLD_VIRTUAL_PYTHONHOME:-}" ]
    then
        PYTHONHOME="${_OLD_VIRTUAL_PYTHONHOME:-}"
        export PYTHONHOME
        unset _OLD_VIRTUAL_PYTHONHOME
    fi
    if [ -n "${BASH:-}" -o -n "${ZSH_VERSION:-}" ]
    then
        hash -r
    fi
    if [ -n "${_OLD_VIRTUAL_PS1:-}" ]
    then
        PS1="${_OLD_VIRTUAL_PS1:-}"
        export PS1
        unset _OLD_VIRTUAL_PS1
    fi
    unset VIRTUAL_ENV
    if [ ! "$1" = "nondestructive" ]
    then
        unset -f deactivate
    fi
}


portkill () {
    local _hasbeenkilled=0
    if sudo lsof -t -i ":$1" | xargs kill 2> /dev/null; then
        echo -e "\nKilled :$1"
        _hasbeenkilled=1
    fi
    if sudo docker container ls | grep ":$1" | awk '{print $1}' | xargs docker kill 2> /dev/null; then
        echo -e "\nKilled :$1"
        _hasbeenkilled=1
    fi

    if [ $_hasbeenkilled -eq 0 ]; then
        echo -e "\nNothing killed"
    fi

}


# vim: syntax=sh ts=4 sts=4 shiftwidth=4 expandtab
