#!/usr/bin/env bash
cpuOut="cpu.data"
memOut="mem.data"
upTimeOut="uptime.data"
interval=1

unset  LANG
function getMem() {
    echo "`date +%H:%M:%S` `free -w |grep Mem |awk -F: '{print $2}' `" >> ${memOut}
}

function getCpu() {
sar -u 1 1  |grep all |grep -v Average >> ${cpuOut}
}

function getUpTime() {
    uptime | awk '{print $1,$(NF-2),$(NF-1),$(NF) }' | tr -d ',' >> ${upTimeOut}
}

while true
do
getCpu &
getMem &
getUpTime
sleep ${interval}
done