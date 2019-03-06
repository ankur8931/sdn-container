#!/bin/bash
BRIDGE=ovs-br1
declare  -a ports=$(ovs-vsctl list-ports $BRIDGE)

for i in $ports
do
    $(ovs-vsctl del-port $BRIDGE $i)
done
