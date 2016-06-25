#!/bin/bash

# Script to extract information from a logfile
# Creator: Fritz Schlapbach
# Date: 25.06.2016

# Change name of logfile here
LogFile="bpe.log"
ResultLogFile="result.log"

# Check if new logfile already exist and delete it if yes
if [[ -f $ResultLogFile ]]; then
	rm $ResultLogFile
fi

# Set linebreak
IFS=$'\n'

# Loop through lines of logfile and get desired strings
for line in $(less $LogFile | grep "FAILED" | grep "GEAR")
do
	Tmp_Timestamp=$(echo $line | cut -d "I" -f 1)
	Tmp_Description=$(echo $line | awk -F"description" '{print $2}' | awk -F"id" '{print $1}' | rev | cut -c 4- | rev)
	Tmp_GEAR=$(echo $line | grep -P -o 'GEAR-[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}')

	# Check if the description was available in the current line. If not set information.
	if [[ -z $Tmp_Description ]]; then
		Tmp_Description="\"description\":\"No description found.\""
	else
		Tmp_Description="\"description$Tmp_Description"
	fi

	# Write strings to new file
	echo "$Tmp_Timestamp $Tmp_Description $Tmp_GEAR" >> $ResultLogFile
done

# Show new file to user
cat $ResultLogFile

exit 0