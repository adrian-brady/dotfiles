#!/bin/bash
curUpTime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
echo $curUpTime
