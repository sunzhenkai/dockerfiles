#!/bin/sh
script_dir=$(dirname $0)

MYSQL_HOST=127.0.0.1
MYSQL_USER=azkaban
MYSQL_PASSWORD=azkaban
MYSQL_PORT=3306
EXECUTOR_PORT=12321

[ "$AZKABAN_MYSQL_HOST" != "" ] && MYSQL_HOST=$AZKABAN_MYSQL_HOST
[ "$AZKABAN_MYSQL_USERNAM" != "" ] && MYSQL_USER=$AZKABAN_MYSQL_USERNAM
[ "$AZKABAN_MYSQL_PASSWORD" != "" ] && MYSQL_PASSWORD=$AZKABAN_MYSQL_PASSWORD
[ "$AZKABAN_MYSQL_PORT" != "" ] &&  MYSQL_PORT=$AZKABAN_MYSQL_PORT
[ "$AZKABAN_EXECUTOR_PORT" != "" ] &&  EXECUTOR_PORT=$AZKABAN_EXECUTOR_PORT

sed -i "s/mysql.port=3306/mysql.port=$MYSQL_PORT/g" ${script_dir}/../conf/azkaban.properties
sed -i "s/mysql.password=azkaban/mysql.password=$MYSQL_PASSWORD/g" ${script_dir}/../conf/azkaban.properties
sed -i "s/mysql.user=azkaban/mysql.user=$MYSQL_USER/g" ${script_dir}/../conf/azkaban.properties
sed -i "s/mysql.host=localhost/mysql.host=$MYSQL_HOST/g" ${script_dir}/../conf/azkaban.properties
echo "executor.port=${EXECUTOR_PORT}" >> conf/azkaban.properties
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
sh /app/azkaban-exec-server/bin/start-exec.sh
pid=$(cat currentpid)

# activate
# [ port file not exist ] or [ request failure ] or [ process is alive ]
while [ $(ls ${script_dir}/../executor.port > /dev/null 2>&1; echo $?) -ne 0 ] || \
    # https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-executor-server
    [ $(curl -G "localhost:$(cat ${script_dir}/../executor.port)/executor?action=activate" > /dev/null 2>&1; echo $?) -ne 0 ] || \
    [ -e "/proc/${pid}" ]
do
    sleep 1
done

# watch pid
while test -e "/proc/${pid}"; do
    echo "[$(date)] azkaban process is running. [pid=$pid]"
    sleep 3
done