datetime=$(date +"%Y-%m-%d %H:%M:%S")

cpu_usage=$(top -bn 1 | awk '/^%Cpu/{printf "{\"us\":%s, \"sy\":%s, \"id\":%s, \"wa\":%s}", $2, $4, $8, $10}')
cpu_info=$(echo "$cpu_usage" | jq -r '{us, sy, id, wa}')

memory_usage=$(top -bn 1 | awk '/^MiB Mem/{printf "{\"total\":%d, \"free\":%d, \"used\":%d}", int($3/1024), int($5/1024), int($7/1024)}')
memory_info=$(echo "$memory_usage" | jq -r '{total, free, used}')

disk_usage=$(df -BG --output=size,avail | awk 'NR==2{printf "{\"total\":%d, \"free\":%d, \"used\":%d}", $1, $2, $3}')
disk_info=$(echo "$disk_usage" | jq -r '{total, free, used}')

echo "{\"datetime\":\"$datetime\", \"cpu\":$cpu_info, \"memory\":$memory_info, \"disk\":$disk_info}"
