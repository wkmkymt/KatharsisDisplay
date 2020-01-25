# Base Image
FROM ruby:2.5

# Set Language
ENV LANG C.UTF-8

# Install Packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs mariadb-client

# Make work directory
ENV APP_ROOT /app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# Add Gemfile
ADD Gemfile $APP_ROOT/Gemfile
ADD Gemfile.lock $APP_ROOT/Gemfile.lock

# Install Gem
RUN bundle install
ADD . $APP_ROOT

# Start Main Process
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
