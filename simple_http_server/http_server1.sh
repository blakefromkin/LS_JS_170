#!/bin/bash

function server () {
  while true
  do
    read method path version
    if [[ $method = "GET" ]]
      then
      echo "HTTP/1.1 200 OK"
    else
      echo "HTTP/1.1 400 Bad Request"
    fi
  done
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}

# Compared to the prior version of this file, this code enforces:
# The messages, or requests, should consist of one line comprised of three parts: request method, path, HTTP version.
# The method should be GET since our server only responds to GET requests.
