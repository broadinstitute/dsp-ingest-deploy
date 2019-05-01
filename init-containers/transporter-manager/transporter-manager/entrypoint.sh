#!/bin/bash

declare -ra JAVA_OPTS_ARRAY=(
   # Point to rendered config file.
   -Dconfig.file=/etc/application.conf
   # Constrain memory.
   -server
   -Xmx1g
   -Xmx1g
   # GC settings (copied from Clio for now).
   -XX:+PrintFlagsFinal
   -XX:+PrintGCTimeStamps
   -XX:+PrintGCDateStamps
   -XX:+PrintGCDetails
)

# Inject options into normal entrypoint.
JAVA_OPTS="${JAVA_OPTS_ARRAY[*]}" exec /app/bin/transporter-manager
