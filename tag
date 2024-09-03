#!/usr/bin/env bash

# ==========================================================
# Author: https://github.com/sevaho
# Repo: https://github.com/sevaho/scripts
#
# Small utlity to tag a repository with the next tags (major, minor or path)
# ==========================================================

LATEST_TAG=`git describe --tags $(git rev-list --tags --max-count=1)`

major=`echo $LATEST_TAG | cut -d. -f1`
minor=`echo $LATEST_TAG | cut -d. -f2`
patch=`echo $LATEST_TAG | cut -d. -f3`

if [ -z "$1" ]
  then
    echo "No action supplied, requires: min, patch or alpha"
    exit 1
fi

echo "Old tag: $LATEST_TAG"

if [ $1 == "minor" ]; then
    minor=`expr $minor + 1`
    patch=0
elif [ $1 == "patch" ]; then
    if [[ $patch == *"alpha"* ]]; then
        patch=`echo $patch | cut -d- -f1`
        patch=`expr $patch + 1`
    else
        patch=`expr $patch + 1`
    fi
elif [ $1 == "alpha" ]; then
    if [[ $patch == *"alpha"* ]]; then
        alpha=`echo $LATEST_TAG | cut -d. -f4`
        alpha=`expr $alpha + 1`
        patch="$patch.$alpha"
    else
        patch=`expr $patch + 1`
        patch="$patch-alpha.1"
    fi
else
    echo "No correct action supplied, requires: minor, patch or alpha"
    exit 1
fi
NEW_TAG=$major.$minor.$patch
echo "New tag will be: $NEW_TAG"
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	git tag $NEW_TAG
	git push origin $NEW_TAG
else
    echo "[ERROR] Command Cancelled!!"
    exit 1
fi
