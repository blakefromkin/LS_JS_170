#!/bin/bash

function server () {
  while true
  do
    read method path version
    if [[ $method = "GET" ]]
      then
        fullPath="./www/$path"
        if [[ -f $fullPath ]]
        then
            echo -e "HTTP/1.1 200 OK\r\n"; cat $fullPath
        else
          echo -e "HTTP/1.1 404 Not Found\r\n"
        fi
    else
      echo -e "HTTP/1.1 400 Bad Request\r\n"
    fi
  done
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}

# Compared to the prior version of this file, this code checks to make sure the file path being requested exists, and returns the HTML if so 
