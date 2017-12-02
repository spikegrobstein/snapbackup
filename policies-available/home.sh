#! /bin/bash

TEMP_DIR=/mnt

for USER_DIR in /home/*
do
	USER_DIR_ARCHIVE="${TEMP_DIR}/${USER_DIR}.tar"

	tar cf "$USER_DIR_ARCHIVE" -C / "home/${USER_DIR}"

	echo $USER_DIR_ARCHIVE
done

