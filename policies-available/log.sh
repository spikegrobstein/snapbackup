#! /bin/bash

# lets' tar up the various log directories that we want to keep
tar cfz /tmp/var_log.tar.gz -C / var/log

echo /tmp/var_log.tar.gz
