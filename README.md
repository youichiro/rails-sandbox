# rails-sandbox
Railsで色々試したいときに使うためのプロジェクト

## 環境
- ruby 2.7.2
- rails 6.0.3.4

## 起動

```sh
$ git clone https://github.com/youichiro/rails-sandbox.git
$ cd rails-sandbox
$ make init    # 初回時のみ実行する
$ make up-dev  # 開発環境を立ち上げる
```

## makeコマンド

```sh
$ make bundle-install  # gemを追加する
$ make migrate         # migrateする
$ make console         # rails consoleを起動する
```

## rails newまでにやったこと

```sh
$ brew upgrade rbenv ruby-build
$ rbenv install 2.7.2
$ rbenv local 2.7.2
$ gem install bundler
$ gem install -v 6.0.3.4 —N rails  # -N: ドキュメントをインストールしない

# -M: ActionMailerのセットアップをスキップ
# -C: ActionCableのセットアップをスキップ
$ rails new -d mysql --api -M -C rails-sandbox
```

## やりたいこと
- [x] docker-composeで開発環境構築
- [x] cors
- [x] rubocop
- [ ] ユーザ承認API
- [ ] puma
- [ ] test
- [ ] swagger
- [ ] logger
- [ ] replica DB
- [ ] sidekiq


## rubocopの導入
- Gemfileに以下を追加して`bundle install`

```Gemfile
group :development do
  # rubocop
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end
```

- `.rubocop.yml`を作成してルールを記述
- `bundle exec rubocop`を実行してチェック
- [公式ドキュメント](https://docs.rubocop.org/rubocop/0.93/index.html)で設定について確認できる
