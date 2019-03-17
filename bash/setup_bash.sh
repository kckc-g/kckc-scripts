BASE_DIR=$(dirname ${BASH_SOURCE[0]})
FILENAME=$(basename ${BASH_SOURCE[0]})

BASE_DIR=`readlink -e ${BASE_DIR}`

BASHRC=${1:-~/.bashrc}
            
echo "" >> ${BASHRC}

for f in `/bin/ls -1 ${BASE_DIR}/*.sh`
do
    if ! [ "${FILENAME}" = "$(basename $f)" ]
    then
        echo ". ${BASE_DIR}/$(basename $f)" >> ${BASHRC}
    fi
done
           
echo "" >> ${BASHRC}
