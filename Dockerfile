FROM ruby:2.6.3

ENV APP_HOME /sinatra-cron

RUN apt-get update -qq && apt-get install -y build-essential cron && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/apt/* && \
    mkdir $APP_HOME

WORKDIR $APP_HOME

ADD . $APP_HOME
#bundle install all the required gems
RUN bundle install && \
    chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]
