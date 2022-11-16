#!/bin/bash

function server () {
  while true
  do
    message_arr=()
    check=true
    while $check
    do
      read line
      message_arr+=($line)
      if [[ "${#line}" -eq 1 ]]
      then
        check=false
      fi
    done
    method=${message_arr[0]}
    path=${message_arr[1]}
    if [[ $method = "GET" ]]
      then
        fullPath="./www/$path"
        if [[ -f $fullPath ]]
        then
          echo -ne "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: $(wc -c <'./www/'$path)\r\n\r\n"; cat "./www/$path"
    else
      echo -ne 'HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\n\r\n'
    fi
  else
    echo -ne 'HTTP/1.1 400 Bad Request\r\nContent-Length: 0\r\n\r\n'
    fi
  done
}

coproc SERVER_PROCESS { server; }

nc -lkv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}

# Compared to the prior version of this file, this code makes this server able to communicate with a browser rather than just our local command line client
# Most browsers automatically include a number of headers with every request, so the request message would contain multiple lines
# The response we are sending is very basic, and doesn't necessarily provide a browser with all the information it needs to process it.
# The browser might terminate the connection after 1 request-response cycle, but the -k flag in the last line forces netcat to stay listening for another connection
# Can make a request in a browser like http://localhost:2345/leopard.html
