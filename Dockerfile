FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential \
  cron

ENV APP_HOME /sinatra-cron
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

RUN crontab -l | { cat; echo ""; } | crontab -

RUN bundle exec whenever --update-crontab
