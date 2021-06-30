#!/bin/bash

cd env/region

for REGION in $(ls)
do
	for ENV in $(cd $REGION && ls)
	do
	  echo "$REGION/$ENV"
	  //aws creds set
	  //tf init
	  //tf plan
	  //tf apply
	done
done

