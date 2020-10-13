# rails-sandbox
Railsで色々試したいときに使うためのプロジェクト

## 環境
- ruby 2.7.2
- rails 6.0.3.4

## 起動

```sh
$ git clone https://github.com/youichiro/rails-sandbox.git
$ cd rails-sandbox
$ make init                   # 初回時のみ実行する
$ docker-compose up           # railsサーバを起動
$ open http://localhost:3001  # welcomeページを表示
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
- [x] ユーザのセッション認証
- [x] serializer
- [ ] puma
- [ ] test
- [ ] swagger
- [ ] logger
- [ ] replica DB
- [ ] sidekiq
- [ ] redis cache
- [ ] OAuth


## CORSの設定
- Gemfileのコメントを外して`bundle install`

```ruby:Gemfile
gem 'rack-cors'
```

- `config/initializers/cors.rb`を編集

```ruby:config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch('CORS_ALLOW_ORIGIN') { '' }

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

- 許可したいオリジンがあれば環境変数`CORS_ALLOW_ORIGIN`に値をセットする


## rubocopの導入
- Gemfileに以下を追加して`bundle install`

```ruby:Gemfile
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

## ユーザのセッション認証
PR: https://github.com/youichiro/rails-sandbox/pull/1<br>
リクエストを送信したユーザがログイン済みかどうかを判定するためのセッション認証機能を実装した

```ruby:app/controllers/api/base_controller.rb
# app/controllers/api/base_controller.rb

class Api::BaseController < ApplicationController
  before_action :login_required

  def login_required
    if !current_user
      render json: { message: 'unauthorized' }, status: 401
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
```

- `current_user`メソッド
  - セッションに保存されている`user_id`を取得してユーザインスタンスを`@current_user`に代入する
  - もしセッションに`user_id`が無ければnilを返す
  - `||=`はもし左辺が偽か未定義ならば右辺を代入する演算子
- `login_required`メソッド
  - もしセッション認証されていなければ401を返す
- `before_action :login_required`
  - `Api::BaseController`を継承したコントローラのアクション実行前に認証チェックを行う


```ruby:app/controllers/api/sessions_controller.rb
# app/controllers/api/sessions_controller.rb

class Api::SessionsController < Api::BaseController
  skip_before_action :login_required, only: [ :create ]

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: 'ok' }, status: 200
    else
      render json: { message: 'unauthorized' }, status: 401
    end
  end

  def destroy
    reset_session
    @current_user = nil
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
```

- `sessions#create`アクション
  - パラメータから`email`と`password`の値を受け取り、ユーザが存在する&パスワード認証できたら、セッションを作成し200を返す
  - `skip_before_action`でセッション認証をスキップしている
- `sessions#destroy`アクション
  - セッションを削除する


## Active Model Serializerの導入
PR: https://github.com/youichiro/rails-sandbox/pull/2<br>
各モデルのSerializersを作成し、レスポンスとして返す属性を制御する<br>
意図しない値を返してしまうと情報漏洩に繋がるため、クライアント側に渡す属性を明示する<br>
参考：[パーフェクトRails著者が解説するdeviseの現代的なユーザー認証のモデル構成について](https://joker1007.hatenablog.com/entry/2020/08/17/141621)
