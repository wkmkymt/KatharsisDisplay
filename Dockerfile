# Base Image
FROM ruby:2.5.8

# Set Language
ENV LANG C.UTF-8

# Set Timezone
ENV TZ="Asia/Tokyo"

# Install Packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs mariadb-client  \
&& apt install ghostscript -y \
&& apt-get install -y imagemagick libmagickwand-dev

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

#Copy for changing policy of ImageMagick
COPY ./policy.xml /etc/ImageMagick-6/policy.xml

# Start Main Process
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
