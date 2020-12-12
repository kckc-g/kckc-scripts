#!/bin/bash

# This script hooks into bash's prompt display command to execute abitrary commands.
#
# That is, by setting env variable PROMPT_COMMAND to a shell function,
#   Bash will run the function before displaying command prompt (every single time)
#
# Tries to be secure by checking all sorts of condition

# temp files stored in same directory as this script
# 	in a temp folder called '.post_exec_files'
BASE_DIR=$(dirname ${BASH_SOURCE[0]})/.post_exec_files

# Create temp folder if not exist, ignore error if it does
mkdir -p ${BASE_DIR} 2> /dev/null

# Check that I won the directory
# 	Do not proceed if I dont own this
# (Security check!)
if ! [ -O ${BASE_DIR} ]
then
	echo "Current user must be the owner of dir: ${BASE_DIR}"
	return
fi

# Chmod this temp dir to 700, no one else gets to touch it
# 	Do not proceed if this command fails
chmod 700 ${BASE_DIR}
if [ "$?" -ne 0 ]
then
	echo "Unable to set permission to 700 for dir: ${BASE_DIR}"
fi

if [ -e "/proc/sys/kernel/random/uuid" ]
then
    export SESSION_UUID=$(cat /proc/sys/kernel/random/uuid | tr -dc 'a-zA-Z0-9')
else
    export SESSION_UUID=$(/usr/bin/uuidgen | tr -dc 'a-zA-Z0-9')
fi

export POSTEXEC_CMD_FILE="${BASE_DIR}/postexec.${SESSION_UUID}"
export POSTEXEC_EXE_FILE="${POSTEXEC_CMD_FILE}.exec"

# Remove all temp files, to stop building up of temp files
# This is ok as the temp files are used immediate after creation
find ${BASE_DIR} -maxdepth 1 -mtime +1 -name 'postexec.*' -delete

unset BASE_DIR

# Check that we dont have the temp files stamped with current session's uuid
if [ -e ${POSTEXEC_CMD_FILE} ] || [ -e ${POSTEXEC_EXE_FILE} ]
then
	echo "${POSTEXEC_CMD_FILE} and ${POSTEXEC_EXE_FILE} need to be removed" 
	return
fi

function postexec() {
    while true
    do
        if [ -e "${POSTEXEC_CMD_FILE}" ]
        then
            mv ${POSTEXEC_CMD_FILE} ${POSTEXEC_EXE_FILE}

            . "$POSTEXEC_EXE_FILE"
        else
            break
        fi
    done

    if [ -e "${POSTEXEC_EXE_FILE}" ]
    then
        rm "${POSTEXEC_EXE_FILE}"
    fi
}

export PROMPT_COMMAND=postexec

