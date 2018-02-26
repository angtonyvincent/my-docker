FROM jupyter/pyspark-notebook

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root

# Test
RUN echo "TEST"

RUN echo "Line 1" >  /Tony/test.txt && \
    echo "Line 2" >> /Tony/test.txt && \
    echo "Line 3" >> /Tony/test.txt

RUN echo $SPARK_HOME

# Spark config for Mesos in cluster mode
RUN echo $'spark.ssl.noCertVerification true\n\
    spark.driver.cores 1\n\
    spark.driver.memory 1G\n\
    spark.driver.supervise true\n\
    spark.executor.memory 1G\n\
    spark.master mesos://192.168.237.146/service/spark\n\
    spark.mesos.driver.labels DCOS_SPACE:/spark\n\
    spark.mesos.executor.docker.forcePullImage true\n\
    spark.mesos.executor.docker.image mesosphere/spark:2.1.0-2.2.1-1-hadoop-2.6\n\
    spark.mesos.uris http://master.dcos/service/hdfs/v1/endpoints/hdfs-site.xml,http://master.dcos/service/hdfs/v1/endpoints/core-site.xml\n\
    spark.submit.deployMode cluster\n'\
    >> $SPARK_HOME/conf/spark-defaults.conf
