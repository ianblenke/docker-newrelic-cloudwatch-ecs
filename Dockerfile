FROM ubuntu:trusty
MAINTAINER Ian Blenke <ian@blenke.com>

RUN apt-get update && apt-get install -y vim curl telnet build-essential ruby-dev libxml2-dev libxslt-dev ruby && apt-get clean

RUN gem install --no-rdoc --no-ri bundler
RUN curl -L https://github.com/newrelic-platform/newrelic_aws_cloudwatch_plugin/archive/latest.tar.gz > latest.tar.gz

RUN mkdir -p /newrelic_aws_cloudwatch_plugin
RUN tar -zxf latest.tar.gz -C /newrelic_aws_cloudwatch_plugin

WORKDIR /newrelic_aws_cloudwatch_plugin
RUN mv newrelic_aws_cloudwatch_plugin-latest/* .
RUN rm -rf newrelic_aws_cloudwatch_plugin-latest
RUN bundle install --clean --quiet --without test

ADD newrelic_plugin.yml config/newrelic_plugin.yml

CMD ["bundle", "exec", "/newrelic_aws_cloudwatch_plugin/bin/newrelic_aws"]
