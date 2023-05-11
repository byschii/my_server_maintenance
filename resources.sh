sudo apt-get install jq -y

datetime=$(date +"%Y-%m-%d %H:%M:%S")

cpu_usage=$(top -bn 1 | awk '/^%Cpu/{printf "{\"us\":%s, \"sy\":%s, \"id\":%s, \"wa\":%s}", $2, $4, $8, $10}')
cpu_info=$(echo "$cpu_usage" | jq -r '{us, sy, id, wa}')

memory_usage=$(top -bn 1 -d 0 | awk '/^KiB Mem/{printf "{\"total\":%d, \"free\":%d, \"used\":%d}", int($4/1000), int($6/1000), int($8/1000)}')
memory_info=$(echo "$memory_usage" | jq -r '{total, free, used}')

disk_usage=$( df -BG | awk '/xvda/{printf "{ \"free\":%d, \"used\":%d}", $2, $3}' )
disk_info=$(echo "$disk_usage" | jq -r '{total, free, used}')

echo "{\"datetime\":\"$datetime\", \"cpu\":$cpu_info, \"memory\":$memory_info, \"disk\":$disk_info}"
