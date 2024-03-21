FROM amd64/flink:1.18.1-scala_2.12-java11
USER root

# install python3 and pip3
RUN apt-get update -y && \
apt-get install -y  python3 python3-pip default-jdk python3-dev openjdk-11-jdk && rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/bin/python3 /usr/bin/python

#RUN : \
#  && pip3 install --upgrade pip \
#  && pip3 install "apache-flink==1.18.1" \
#  && :

# Install Connectors
RUN wget -P /opt/flink/lib https://repo1.maven.org/maven2/org/apache/flink/flink-connector-pulsar/4.1.0-1.18/flink-connector-pulsar-4.1.0-1.18.jar

# add python script
USER flink
RUN mkdir /opt/flink/usrlib
ADD processes/example.py /opt/flink/usrlib/example.py