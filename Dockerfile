# Using ruby image
# FROM ruby:3.1
FROM ruby:3.1.2-slim


# Set the application directory
WORKDIR /app

# Copy files to container from host .
COPY Gemfile ./
COPY Gemfile.lock ./
COPY entrypoint.sh /usr/bin/

# Install dependencies.(RUN = exec when docker image is created from dockerfile.)
RUN apt update -qq && apt install -y postgresql-client build-essential libpq-dev vim git\
    && bundle install \
    && chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

# Make port 3000 available for links and/or publish
EXPOSE 3000

COPY ./ ./

# Start service. (CMD = exec when docker container is created from docker image.)
CMD ["rails", "server", "-b", "0.0.0.0"]
