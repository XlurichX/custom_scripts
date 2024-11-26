#!/bin/bash

echo ""
echo -e "\e[1;32m TOP-3 CPU Load PID \e[0m"
echo ""
echo "PID    |           Name                 | CPU (%)"
echo "----------------------------------------------"

# sort by awk cpu
# %-6s, 30s - indent
ps aux --sort=-%cpu | awk 'NR>1 && NR<=4 {printf "%-6s | %-30s | %-15s\n", $2, $11, $3}'

echo ""

echo -e "\e[1;35m TOP-3 RAM Load PID \e[0m"
echo ""
echo "PID    |           Name                 | RAM (%)"
echo "----------------------------------------------"

# sort by awk mem
ps aux --sort=-%mem | awk 'NR>1 && NR<=4 {printf "%-6s | %-30s | %-15s\n", $2, $11, $4}'

echo ""
