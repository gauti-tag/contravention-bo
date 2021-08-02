FROM ruby:2.6.0-alpine3.8

# Author's information
LABEL maintainer="jean.toure@ngser.com"

ARG HOST_UID=1000
ARG HOST_GID=1000

# Install dependances
ENV BUNDLER_VERSION=2.0.2

RUN apk add --update --no-cache \
  binutils-gold \
  build-base \
  curl \
  file \
  g++ \
  gcc \
  git \
  less \
  libstdc++ \
  libffi-dev \
  libc-dev \
  linux-headers \
  libxml2-dev \
  libxslt-dev \
  libgcrypt-dev \
  make \
  netcat-openbsd \
  openssl \
  pkgconfig \
  postgresql-dev \
  python \
  tzdata

RUN apk add  --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.9/main/ nodejs=10.19.0-r0 yarn
RUN apk --update add imagemagick

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
# Set the working directory of everything to the directory we just made.
RUN addgroup -g $HOST_GID ngser
RUN adduser -u $HOST_UID -G ngser -h /home/ngser -D ngser
USER ngser
RUN mkdir /home/ngser/app
WORKDIR /home/ngser/app

# Copy the gemfile and gemfile.lock so we can run bundle on it
# Install and run bundle to get the app ready
RUN gem install bundler
COPY --chown=ngser:ngser Gemfile .
COPY --chown=ngser:ngser Gemfile.lock .
COPY --chown=ngser:ngser package.json .
COPY --chown=ngser:ngser yarn.lock .
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install

# Copy the Rails application into place
COPY --chown=ngser:ngser . .

# Add a script to be executed every time the container starts.
ENTRYPOINT ["sh", "entrypoint.sh"]

# Expose port 3000 on the container
EXPOSE 3000

# Clear cache (optional)
#RUN bundle exec rake tmp:clear

# Run the application on port 3000
CMD ["bundle", "exec", "puma"]