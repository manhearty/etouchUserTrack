#!/bin/bash
#Author: MP Nadar
#Date: 05th April 2016
#Purpose : Monitor User Activity


exit_report(){
echo "$(date) Monitoring Terminated."
}
trap "exit_report; exit;" 0

lockmon() {
adddate() {
    while IFS= read -r line; do
      echo "$(date) $line" | grep "boolean" | sed 's/   boolean true/Screen Locked/' | sed 's/   boolean false/Screen Unlocked/'
    done
}
echo "$(date) Monitoring Started."
dbus-monitor --session "type='signal',interface='com.ubuntu.Upstart0_6'" | adddate

}

lockmon >> lock_screen.log
