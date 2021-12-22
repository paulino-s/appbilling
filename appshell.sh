#!/bin/bash

# Start the java app
java -jar /app.jar &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start java microservice: $status"
  exit $status
fi
nginx &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx process: $status"
  exit $status
fi

while sleep 60; do
  ps aux |grep app.jar |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep nginx |grep -q -v grep
  PROCESS_2_STATUS=$?
 
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done