#!/bin/bash
#Author: MP Nadar
#Purpose : Monitoring User Activity
#Date : 05th April 2016

#if ps -ef | grep dbus-monitor | grep -v grep
#then
#  exit 7

#else

echo  "$(date) USER_LOGGED_IN" >> ${HOME}/$(date +%F)

dbus-monitor --session "type='signal',interface='org.gnome.ScreenSaver'" | \
(
  while true; do
    read X
    if echo $X | grep "boolean true" &> /dev/null; then
    echo  "$(date) SCREEN_LOCKED";
    elif echo $X | grep "boolean false" &> /dev/null; then
    echo  "$(date) SCREEN_UNLOCKED";
    fi
 done

  echo "###########################"
  echo $(last $USER)
) >> ${HOME}/$(date +%F)

#fi
