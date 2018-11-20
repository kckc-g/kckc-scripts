#!/bin/bash

CD_PATH_CACHE_MAX=10

function cd () {
    if [ $# -eq 0 ]
    then
        for i in $(seq 0 $((${#CD_PATH_CACHE[@]}-1)))
        do 
            if [ $(($i % 2)) -eq 0 ]
            then
                echo $((${#CD_PATH_CACHE[@]}-${i}-1)): ${CD_PATH_CACHE[$i]}
            else
                echo -e ${GREEN}$((${#CD_PATH_CACHE[@]}-${i}-1)): ${CD_PATH_CACHE[$i]}${NORMAL}
            fi
        done

        return
    fi

    local args
    
    if [ $# -eq 1 ] && [[ $1 =~ ^-[0-9]$ ]]
    then
        local pos=$((${#CD_PATH_CACHE[@]}+${1}-1))
        args=${CD_PATH_CACHE[$pos]}
    else
        args="$@"
    fi

    current=`pwd -P`
    
    local index=0
    for line in ${CD_PATH_CACHE[@]}; do
        if [ "$line" = "$current" ]
        then
            unset CD_PATH_CACHE[$index]
            break
        fi
        let index++
    done

    if [ ${#CD_PATH_CACHE[@]} -ge ${CD_PATH_CACHE_MAX} ]
    then
        CD_PATH_CACHE=("${CD_PATH_CACHE[@]:1}" "$current")
    else
        CD_PATH_CACHE=("${CD_PATH_CACHE[@]:0}" "$current")
    fi

    command cd "$args"
}

