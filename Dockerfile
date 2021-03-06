FROM ruby:2.5.0

ENV LANG C.UTF-8

ENV TZ Asia/Tokyo
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    mysql-client \
    vim

# install node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs

# install yarn
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN bundle config build.nokogiri --use-system-libraries

ENV APP /app
RUN mkdir $APP
WORKDIR $APP

# bundle install
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --path vendor/bundle
#
# # yarn install
COPY package.json package.json
COPY yarn.lock yarn.lock
RUN yarn install

ADD . $APP
