#! /bin/bash

# let's create an archive of /etc
tar cfz /tmp/etc.tar.gz -C / etc

echo /tmp/etc.tar.gz