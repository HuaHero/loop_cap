#!/bin/bash
#script name:loop_cap.sh

monitor_path="/mnt/paas/kubernetes/kubelet"
#nohup  tcpdump -i any port 80 -s0 -C 100 -Z root -w /tmp/tmp_tcpdump/windowssize.pcap 2>&1 &
day=`data +%Y_%m%d_%H%M_%S`
nohup  tcpdump -i any -s0 -C 100 -Z root -W 20 -w ${monitor_path}/%Y_%m%d_%H%M_%S.pcap 2>&1 &
#

FREEDISK=`df -h|grep "/dev/mapper/vgpaas-kubernetes"|awk '{print $5}'|awk -F % '{print $1}'`

HEADMOST=`ls -lrt $monitor_path  | grep -  | awk '{print $NF}'| head -n 1`

#check free disk status 
#
if [ "$FREEDISK" -ge "50" ];then
    rm -rf $monitor_path/"$HEADMOST"
fi  
