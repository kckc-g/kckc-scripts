

function findname {
    local PATTERN=$1
    shift
    local DIR="."

    if [ "${PATTERN}" = "-p" ]
    then
        DIR="$1"
        shift
        PATTERN=$1
        shift
    fi
    find "$DIR" -name "$PATTERN" "$@"
}


function findgrep {
    local PATTERN=$1
    shift
    local DIR="."

    if [ "${PATTERN}" = "-p" ]
    then
        DIR="$1"
        shift
        PATTERN=$1
        shift
    fi
    find $DIR -name "*.$PATTERN" | xargs grep -s -H --color "$@"
}
