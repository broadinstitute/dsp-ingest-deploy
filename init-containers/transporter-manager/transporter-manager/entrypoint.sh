#!/bin/bash

declare -ra JAVA_OPTS_ARRAY=(
   # Point to rendered config file.
   -Dconfig.file=/etc/application.conf
   # Constrain memory.
   -server
   -Xmx2g
   -Xmx2g
   # GC settings (copied from Hamm for now).
   -XX:NewSize=512m
   -XX:MaxNewSize=512m
   -XX:SurvivorRatio=8
   -XX:+UseParNewGC
   -XX:+UseConcMarkSweepGC
   -XX:+CMSParallelRemarkEnabled
   -XX:+UseCMSInitiatingOccupancyOnly
   -XX:CMSInitiatingOccupancyFraction=60
   -XX:+ScavengeBeforeFullGC
   -XX:+CMSScavengeBeforeRemark
   -XX:+PrintGCDateStamps
   -verbose:gc
   -XX:+PrintGCDetails
   -XX:+PrintClassHistogramBeforeFullGC
   -XX:+PrintClassHistogramAfterFullGC
)

# Inject options into normal entrypoint.
JAVA_OPTS="${JAVA_OPTS_ARRAY[*]}" exec /app/bin/transporter-manager
