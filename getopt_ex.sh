#!/bin/bash

set -- $(getopt -q ab:c "$@")

while [ -n "$1" ]
do
	case "$1"  in
	-a) echo "find -a option";;
	-b) para="$2"
	    echo "find -b opt, with para value $para"
	    shift;;
	-c) echo "find -c option";;
	--) shift
	    break;;
	*) echo "$1 is not an option";;

	esac
	shift
done

count=1;
for para in "$@"
do
echo "parameter #$count:$para"
count=$[ $count + 1 ]
done
