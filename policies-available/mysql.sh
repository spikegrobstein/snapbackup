#! /bin/bash

# config:
DB_USERNAME=root
DB_PASSWORD='mysqlrootpassword'

# dump the mysql database
mysqldump -u $DB_USERNAME --password="$DB_PASSWORD" --add-drop-database --add-drop-table --all-databases --create-options --quick | gzip > /tmp/mysql.sql.gz

echo /tmp/mysql.sql.gz