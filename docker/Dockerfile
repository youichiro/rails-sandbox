# syntax = docker/dockerfile:experimental

FROM ruby:2.7.2-slim-buster as builder

# bundleに必要なものをインストール
RUN apt update && apt install -y \
  default-mysql-client \
  libmariadb-dev \
  build-essential \
  git \
  openssh-client \
  --no-install-recommends

# bundle install
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install -j $(getconf _NPROCESSORS_ONLN)

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

RUN useradd -m app
RUN mkdir /rails && chown app:app /rails
USER app
WORKDIR /rails

RUN mkdir -p /rails/tmp/pids
RUN mkdir -p /rails/tmp/sockets

# bundle installしたファイルをbuilderからコピーする
COPY --chown=app:app --from=builder /usr/local/bundle /usr/local/bundle

# entrypoint.shをコピー
COPY --chown=app:app ./docker/entrypoint.sh /rails/docker/entrypoint.sh

EXPOSE 3001
ENTRYPOINT [ "docker/entrypoint.sh" ]
CMD ["bin/rails", "s", "-p", "3001", "-b", "0.0.0.0"]
