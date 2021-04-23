# assume we have the very big (approx 2 GB) .sql file. -n param means number of files will be created, this case we split to 200 files
cd /path/to/backup/mkdir
split -n 200 database_backup.sql splits/sql

#
cd splits
cat sql* | mysql -u root -p database_name