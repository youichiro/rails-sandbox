# syntax = docker/dockerfile:experimental

FROM ruby:2.7.2-slim-buster

# bundleに必要なものをインストール
RUN apt update && apt install -y \
  default-mysql-client \
  libmariadb-dev \
  build-essential \
  openssh-client \
  --no-install-recommends \
  vim && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /rails

# mount cacheを使ったbundle install
RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle config set app_config .bundle
RUN bundle config set path .cache/bundle
RUN --mount=type=cache,target=/rails/.cache/bundle bundle install && \
  cp -ar .cache/bundle /usr/local/bundle
RUN bundle config set path /usr/local/bundle

# 必要なディレクトリを作成
RUN mkdir -p /rails/tmp/pids
RUN mkdir -p /rails/tmp/sockets

# entrypoint.shをコピー
COPY ./docker/entrypoint.sh /rails/docker/entrypoint.sh

EXPOSE 3001
ENTRYPOINT [ "docker/entrypoint.sh" ]
CMD ["bin/rails", "s", "-p", "3001", "-b", "0.0.0.0"]
