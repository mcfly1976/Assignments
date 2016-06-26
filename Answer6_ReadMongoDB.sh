#!/bin/bash

# Variables
MongoDBName="master"
MongoDBCollection="aufgabe"
MongoDBObjects="999"
TempFile="templist.txt"
SortedFile="thelistsorted.txt"


# Remove file if it already exists
if [[ -f $TempFile ]]; then
	rm $TempFile
fi

COUNTER=0
while [  $COUNTER -lt $MongoDBObjects ]; do
	
	# Get the IP address from MongoDB
	MongoIP=$(mongo $MongoDBName --eval "db.$MongoDBCollection.distinct( \"$COUNTER.ip_address\" )" | sed -e 's/.*"\(.*\)".*/\1/' | sed -n 3p)
	# Get the ID from MongoDB
	MongoID=$(mongo $MongoDBName --eval "db.$MongoDBCollection.distinct( \"$COUNTER.id\" )" | sed -e 's/.*\[\(.*\)\].*/\1/' | tr -d " " | sed -n 3p)

	# Write the information to a temporary file
	echo -e "$MongoID $MongoIP" >> $TempFile

	# Increase counter 
	let COUNTER=COUNTER+1 
done

# Sort the file by IP address
cat $TempFile | awk '{print $2 " % " $0}' | sort -t. -n -k1,1 -k2,2 -k3,3 -k4,4 | sed 's/[^%]*% //' | tr ' ' '\t' > $SortedFil3e

# Remove temporary file
rm $TempFile

# Print the new list
cat $SortedFile

exit 0