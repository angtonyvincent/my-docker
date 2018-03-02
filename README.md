# What it Gives You

Jupyter Notebook 5.2.x

Conda Python 3.x environment

Conda R 3.3.x environment

Scala 2.11.x

pyspark, pandas, matplotlib, scipy, seaborn, scikit-learn pre-installed for Python

ggplot2, rcurl preinstalled for R

Spark 2.2.0 with Hadoop 2.7 for use in local mode or to connect to a cluster of Spark workers

Mesos client 1.2 binary that can communicate with a Mesos master

spylon-kernel

Unprivileged user jovyan (uid=1000, configurable, see options) in group users (gid=100) with ownership over /home/jovyan and /opt/conda tini as the container entrypoint and start-notebook.sh as the default command

A start-singleuser.sh script useful for running a single-user instance of the Notebook server, as required by JupyterHub

A start.sh script useful for running alternative commands in the container (e.g. ipython, jupyter kernelgateway, jupyter lab)

Options for a self-signed HTTPS certificate and passwordless sudo

# Basic Use

The following command starts a container with the Notebook server listening for HTTP connections on port 8888 with a randomly generated authentication token configured.

docker run -it -d -p 8888:8888 angtonyvincent/my-docker

Take note of the authentication token included in the notebook startup log messages. 

Include it in the URL you visit to access the Notebook server or enter it in the Notebook login form.
