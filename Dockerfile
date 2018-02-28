FROM jupyter/pyspark-notebook

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root

# WORKDIR /$SPARK_HOME/conf/

# Download file to Spark's config folder
# ADD https://raw.githubusercontent.com/angtonyvincent/my-docker/master/spark-defaults.conf ./$SPARK_HOME/conf/

# Create Spark's config file
RUN echo 'spark.ssl.noCertVerification true\n\
spark.driver.cores 1\n\
spark.driver.memory 1G\n\
spark.driver.supervise true\n\
spark.executor.memory 1G\n\
spark.master mesos://192.168.237.146/service/spark\n\
spark.mesos.driver.labels DCOS_SPACE:/spark\n\
spark.mesos.executor.docker.forcePullImage true\n\
spark.mesos.executor.docker.image mesosphere/spark:2.1.0-2.2.1-1-hadoop-2.6\n\
spark.mesos.uris http://master.dcos/service/hdfs/v1/endpoints/hdfs-site.xml,http://master.dcos/service/hdfs/v1/endpoints/core-site.xml\n\
spark.submit.deployMode client\n'\ >> spark-defaults.conf

# R Spark config
ENV R_LIBS_USER $SPARK_HOME/R/lib
RUN fix-permissions $R_LIBS_USER

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    tzdata \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

# R packages
RUN conda install --quiet --yes \
    'r-base=3.3.2' \
    'r-irkernel=0.7*' \
    'r-ggplot2=2.2*' \
    'r-sparklyr=0.5*' \
    'r-rcurl=1.95*' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Apache Toree kernel
RUN pip install --no-cache-dir \
    https://dist.apache.org/repos/dist/dev/incubator/toree/0.2.0/snapshots/dev1/toree-pip/toree-0.2.0.dev1.tar.gz \
    && \
    jupyter toree install --sys-prefix && \
    rm -rf /home/$NB_USER/.local && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Spylon-kernel
RUN conda install --quiet --yes 'spylon-kernel=0.4*' && \
    conda clean -tipsy && \
    python -m spylon_kernel install --sys-prefix && \
    rm -rf /home/$NB_USER/.local && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
