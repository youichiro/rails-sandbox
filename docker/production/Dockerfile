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

# appユーザに変更
RUN useradd -m app
RUN mkdir /rails && chown app:app /rails
USER app
WORKDIR /rails

# builderでbundle installしたファイルをコピーする
COPY --chown=app:app --from=builder /usr/local/bundle /usr/local/bundle

# プロジェクトをコピー
COPY --chown=app:app . /rails
RUN mkdir -p /rails/tmp/pids
RUN mkdir -p /rails/tmp/sockets

EXPOSE 3000
ENTRYPOINT [ "docker/entrypoint.sh" ]
# TODO: pumaの起動コマンドにする
CMD ["bin/rails", "s", "-p", "3001", "-b", "0.0.0.0"]
