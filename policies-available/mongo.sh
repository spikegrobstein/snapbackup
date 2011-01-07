#! /bin/bash

TMP="/tmp"
TMP_DIR="mongo"
TMP_ARCHIVE="${TMP}/mongo.tar.gz"

mkdir -p "${TMP}/${TMP_DIR}"

# first, we dump the mongo database to the tmp directory

/usr/local/mongo/bin/mongodump -o ${TMP}/${TMP_DIR} >> ${TMP}/${TMP_DIR}/backup.log

# ok, we're dumped, let's targz this shit
tar cfz $TMP_ARCHIVE -C $TMP $TMP_DIR

rm -rf $TMP_DIR

echo $TMP_ARCHIVE
