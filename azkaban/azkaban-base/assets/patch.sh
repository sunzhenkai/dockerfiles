# azkaban exec server
sed -i 's/${script_dir}/sh ${script_dir}/g' /app/azkaban-exec-server/bin/start-exec.sh
sed -i 's/echo "Using Hadoop from $HADOOP_HOME"/echo "Using Hadoop from $HADOOP_HOME"\nCLASSPATH=${CLASSPATH}:${HADOOP_HOME}\/share\/hadoop\/client\/*:${HADOOP_HOME}\/share\/hadoop\/mapreduce\/*:${HADOOP_HOME}\/share\/hadoop\/hdfs\/*:${HADOOP_HOME}\/share\/hadoop\/common\/lib\/*:${HADOOP_HOME}\/share\/hadoop\/yarn\/lib\/*/g' /app/azkaban-exec-server/bin/internal/internal-start-executor.sh

# copy azkaban web server
sed -i 's/${script_dir}/sh ${script_dir}/g' /app/azkaban-web-server/bin/start-web.sh
sed -i 's/echo "Using Hadoop from $HADOOP_HOME"/echo "Using Hadoop from $HADOOP_HOME"\nCLASSPATH=${CLASSPATH}:${HADOOP_HOME}\/share\/hadoop\/client\/*:${HADOOP_HOME}\/share\/hadoop\/mapreduce\/*:${HADOOP_HOME}\/share\/hadoop\/hdfs\/*:${HADOOP_HOME}\/share\/hadoop\/common\/lib\/*:${HADOOP_HOME}\/share\/hadoop\/yarn\/lib\/*/g' /app/azkaban-web-server/bin/internal/internal-start-web.sh
