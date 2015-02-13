############################################################
# Dockerfile to build ElasticSearch container images
# with support additional languages
############################################################

MAINTAINER Corey Coto <corey.coto@gmail.com>

# Pull base image.
FROM dockerfile/java:oracle-java8

ENV ES_PKG_NAME elasticsearch-1.4.3

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Inquisitor
RUN /elasticsearch/bin/plugin install polyfractal/elasticsearch-inquisitor

# ICU Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-icu/2.4.2

# Japanese (kuromoji) Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-kuromoji/2.4.2

# Smart Chinese Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-smartcn/2.4.3

# Polish Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-stempel/2.4.2
