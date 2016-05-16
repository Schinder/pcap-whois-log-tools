#!/bin/bash
#
# Author: Adam Schinder
# File: test.sh
# Purpose: This bash script just shows a nifty use of the date variables available in bash.

echo "this line is executed at `date +%h-%m-%s`"
sleep 30
echo " this line is executed at `date +%h-%m-%s`"
