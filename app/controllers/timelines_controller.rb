class TimelinesController < ApplicationController
before_action :authenticate_user!

  def show
    user_ids = current_user.followings.pluck(:id)#フォローしているユーザーのidのみを取得
    @articles = Article.where(user_id: user_ids)#配列を渡すとor検索になる
  end
end