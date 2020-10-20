class AccountsController < ApplicationController
def show
  @user = User.find(params[:id])
  if @user == current_user#プロフィールページとアカウントのshowページが一緒なのでaccount/showページに行くとprofileページにリダイレクト
    redirect_to profile_path
  end
end
end