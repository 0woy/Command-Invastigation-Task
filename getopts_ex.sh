#!/bin/bash

while getopts :ab:cd opt
do
	case "$opt" in
	a) echo "find the -a option";;
	b) echo "find the -b option, with value $OPTARG";;
	c) echo "find the -c option";;
	d) echo "find the -d option";;
	*) echo "Unknown option: $opt";;
	esac
done

	shift $[ $OPTIND - 1] #OPTIND(getopts의 현 위치)를 처음으로 돌립니다.
count=1
for para in "$@"
do
	echo "Parameter $count: $para"
	count=$[ $count + 1 ]
done
