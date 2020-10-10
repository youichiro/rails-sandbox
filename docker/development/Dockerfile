# syntax = docker/dockerfile:experimental

FROM ruby:2.7.2-slim-buster as builder

# bundleに必要なものをインストール
RUN apt update && apt install -y \
  default-mysql-client \
  libmariadb-dev \
  build-essential \
  openssh-client \
  --no-install-recommends

WORKDIR /rails

# mount cacheを使ったbundle install
RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle config set app_config .bundle
RUN bundle config set path .cache/bundle
RUN --mount=type=cache,target=/rails/.cache/bundle bundle install && \
  cp -ar .cache/bundle /usr/local/bundle
RUN bundle config set path /usr/local/bundle

# multi-stage build
FROM ruby:2.7.2-slim-buster as container

# railsが起動する最低限のものにする
RUN apt update && apt install -y \
  default-mysql-client \
  libmariadb-dev \
  --no-install-recommends \
  vim && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /rails

# 必要なディレクトリを作成
RUN mkdir -p /rails/tmp/pids
RUN mkdir -p /rails/tmp/sockets

# コンテナ起動後もbundle installしたいのでbundlerをインストール
RUN gem install bundler

# builderでbundle installしたファイルをコピーする
COPY --from=builder /usr/local/bundle /usr/local/bundle

# entrypoint.shをコピー
COPY ./docker/entrypoint.sh /rails/docker/entrypoint.sh

EXPOSE 3001
ENTRYPOINT [ "docker/entrypoint.sh" ]
CMD ["bin/rails", "s", "-p", "3001", "-b", "0.0.0.0"]
