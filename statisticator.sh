#!/bin/bash

#prendere la cpu
#prendere quando ho occupato di disco (ds -s -h)

for file in `ls -tr /var/log/sysstat/sa* | grep -v sar`
do
sar -f $file | head -n 1 | awk '{print $4}'
echo "-----------"
sar -u -f $file | awk '/Average:/{printf("CPU Average: %.2f%\n"), 100 - $8}'
sar -r -f $file | awk '/Average:/{printf("Memory Average: %.2f%\n"),(($3-$5-$6)/($2+$3)) * 100 }'
printf "\n"
done

