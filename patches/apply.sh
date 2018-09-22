#!/bin/sh

MYABSPATH=$(readlink -f "$0")
PATCHBASE=$(dirname "$MYABSPATH")
CMBASE=$(readlink -f "$PATCHBASE/../../../../")
echo $CMBASE

for dir in $(find "$PATCHBASE"/* -type d); do
	PATCHDIR=$(basename "$dir")
	PATCHTARGET=$(echo $PATCHDIR | sed -e 's:_:/:g')
	for patch in $(find "$dir"/* -type f); do
		PATCHNAME=$(basename "$patch")
		echo applying $PATCHDIR/$PATCHNAME to $PATCHTARGET
		cd "$CMBASE/$PATCHTARGET" || exit 1
		patch -p1 < "$PATCHBASE/$PATCHDIR/$PATCHNAME" #|| exit 1
	done
done
