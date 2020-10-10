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

## gemを追加するとき

```sh
$ make bundle-install
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
- [ ] ユーザ承認API
- [ ] puma
- [ ] test
- [ ] rubocop
