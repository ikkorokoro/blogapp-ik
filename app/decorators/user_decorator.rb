# frozen_string_literal: true

module UserDecorator
=begin  Userのインスタンスとして扱うことができるのでUser.rbの中でビューに関するメソッドに関しては
          こちらに記述して置くことでみやすくすることができる
=end


  def display_name#emialの＠より前の部分を習得してそれをアカウント名とする
    # if profile && profile.nickname
    #   profile.nickname
    # else
    #   self.email.split('@').first
    #      #['cohki0305', '@gmail.com']指定した文字で分割して文字列とする
    # end
    #ぼっち演算子
    #profileがない場合にprofile.nicknameを行うとnilclassエラーが起きるのでnillgardをする
    #profileがnilでなければ.nicknameを行う,
    #profileが存在しない場合がある
    profile&.nickname || self.email.split('@').first
  end

  def avatar_image
    if profile&.avatar&.attached?#画像がアップロードされているかのメソッド
      profile.avatar
    else
      'default-avatar.png'
    end
  end
  
end
