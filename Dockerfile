FROM ubuntu:latest
MAINTAINER Vivian Ta

COPY Gemfile .
RUN mkdir -m 755 /srv/webapp && chown root:root /srv/webapp
COPY files/config.ru /srv/webapp/config.ru
ADD *.rb /srv/webapp/
ADD views/ /srv/webapp/views/
RUN apt-get update && apt-get install -y ruby ruby-dev libmysqlclient-dev vim bundler
RUN bundle install
EXPOSE 8080
WORKDIR /srv/webapp
CMD unicorn

