#!/bin/sh
script_dir=$(dirname $0)

MYSQL_HOST=127.0.0.1
MYSQL_USER=azkaban
MYSQL_PASSWORD=azkaban
MYSQL_PORT=3306

if [ "$AZKABAN_MYSQL_HOST" != "" ]; then
    MYSQL_HOST=$AZKABAN_MYSQL_HOST
fi
if [ "$AZKABAN_MYSQL_USERNAM" != "" ]; then
    MYSQL_USER=$AZKABAN_MYSQL_USERNAM
fi
if [ "$AZKABAN_MYSQL_PASSWORD" != "" ]; then
    MYSQL_PASSWORD=$AZKABAN_MYSQL_PASSWORD
fi
if [ "$AZKABAN_MYSQL_PORT" != "" ]; then
    MYSQL_PORT=$AZKABAN_MYSQL_PORT
fi

sed -i "s/mysql.port=3306/mysql.port=$MYSQL_PORT/g" ${script_dir}/../conf/azkaban.properties
sed -i "s/mysql.password=azkaban/mysql.password=$MYSQL_PASSWORD/g" ${script_dir}/../conf/azkaban.properties
sed -i "s/mysql.user=azkaban/mysql.user=$MYSQL_USER/g" ${script_dir}/../conf/azkaban.properties
sed -i "s/mysql.host=localhost/mysql.host=$MYSQL_HOST/g" ${script_dir}/../conf/azkaban.properties

# init database
if [ ! -e 'dbinited' ]; then
    tar -xf azkaban-db-0.1.0-SNAPSHOT.tar.gz
    mariadb --host=$MYSQL_HOST --user=$MYSQL_USER --password=$MYSQL_PASSWORD --database=azkaban <azkaban-db-0.1.0-SNAPSHOT/create-all-sql-0.1.0-SNAPSHOT.sql
    if [ "$?" == "0" ]; then
        touch dbinited
        echo "init database successed"
    else
        echo "init database failed"
    fi
fi

# sh ${script_dir}/internal/internal-start-web.sh 2>&1
[ -e "currentpid" ] && rm currentpid
sh /app/azkaban-web-server/bin/start-web.sh

# wait java process
while test ! -e currentpid; do
    echo "waiting java process to start"
    sleep 1
done

pid=$(cat currentpid)
# watch pid
while test -e "/proc/${pid}"; do
    echo "[$(date)] azkaban process is running. [pid=$pid]"
    sleep 3
done

sh
