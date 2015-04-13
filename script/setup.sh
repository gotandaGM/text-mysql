#/usr/bin/env bash
set -e

cd $(dirname $0)
mysql -uroot -hlocalhost < ../sql/setup.sql
