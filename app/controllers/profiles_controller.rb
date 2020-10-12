class ProfilesController < ApplicationController
before_action :authenticate_user!#コントローラーに設定して、ログイン済ユーザーのみにアクセスを許可する


def show
 @profile = current_user.profile
end

def edit
  # if current_user.profile.present?#profile中があればそれを表示なかったら空のインスタンスを作る
  #   @profile = current_user.profile
  # else
  #   @profile = current_user.build_profile#has_oneの場合は_でかく
  # end
  @profile = current_user.prepre_profile
end

def update
  @profile = current_user.prepre_profile 
  @profile.assign_attributes(profile_params)#生成されているインスタンスに対してデータを入れたい場合はassign_attributesを使う
  if @profile.save
    redirect_to profile_path, notice: 'プロフィール更新！'
  else
    flash.now[:error] = '更新できませんでした'
    render 'edit'
  end
end

private
def profile_params
  params.require(:profile).permit(
    :nickname,
    :introduction,
    :gender,
    :birthday,
    :subscribed,
    :avatar
  )
end
end