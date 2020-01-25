# Base Image
FROM ruby:2.5.1

# Set Language
ENV LANG C.UTF-8

# Install Packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs mysql-client

# Make work directory
ENV APP_ROOT /app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# Add Gemfile
ADD web/Gemfile $APP_ROOT/Gemfile
Add web/Gemfile.lock $APP_ROOT/Gemfile.lock

# Install Gem
RUN bundle install
ADD web $APP_ROOT

# Start Main Process
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
