#ログインしないと使えないresoucesはappsというディレクトリを作ってまとめる
class Apps::ApplicationController < ApplicationController
  before_action :authenticate_user!
end
