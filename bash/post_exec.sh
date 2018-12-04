#!/bin/bash

BASE_DIR=$(dirname ${BASH_SOURCE[0]})

find ${BASE_DIR} -maxdepth=1 -mtime +1 -name 'post_exec*.sh' -delete

export SESSION_UUID=$(/usr/bin/uuidgen | tr -dc 'a-zA-Z0-9')
export POSTEXEC_CMD_FILE="${SCRIPTS_DIR}/postexec.{SESSION_UUID}"

function postexec() {
    local EXEC_FILE=${POSTEXEC_CMD_FILE}.exec"

    while true
    do
        if [ -e "${POSTEXEC_CMD_FILE}" ]
        then
            mv ${POSTEXEC_CMD_FILE} ${EXEC_FILE}

            . "$EXEC_FILE"
        else
            break
        fi
    done

    if [ -e "${EXEC_FILE}" ]
    then
        rm "${EXEC_FILE}"
    fi
}

export PROMPT_COMMAND=postexec

