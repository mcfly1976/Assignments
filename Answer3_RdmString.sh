#!/bin/bash

# Script to create a random alphanumeric string.
# The script checks if the parameter is missing or non numeric.
# Tested with OS X and Fedora 
# Creator: Fritz Schlapbach
# Date: 24.06.16

if [[ -z "$1" || ! -z $(echo "$1" | sed s/[0-9]//g) || "$1" == "0" ]]; then
	echo "Error: This script needs a numeric parameter with at least one number > 0 to generate a random string.
	Example: ./scriptname.sh 10"
	exit 1
else
	# Generate the random string using script parameter $1
	head /dev/urandom | LC_CTYPE=C tr -dc A-Za-z0-9 | head -c$1
fi

exit 0