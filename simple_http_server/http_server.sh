#!/bin/bash

function server () {
  while true
  do
    read message
    echo "You said: $message"
  done
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}

# This code creates a server listening on port 2345.
# Then it takes in any input from the client and assigns it to a message variable.
# Then it outputs to the client "You said:" followed by the value of message
# Basically, it sends a response for every request received 
