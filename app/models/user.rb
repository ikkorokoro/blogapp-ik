# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_many :articles, dependent: :destroy#userが削除された際に紐付いているarticlesも削除する
has_many :likes, dependent: :destroy
has_many :favorite_articles, through: :likes, source: :article#likesテーブルを通してarticlesテーブルのデータを習得する
has_one :profile, dependent: :destroy


def has_written?(article)
  articles.exists?(id: article.id)
end

def has_liked?(article)
  likes.exists?(article_id: article.id)
end


def display_name#emialの＠より前の部分を習得してそれをアカウント名とする
  # if profile && profile.nickname
  #   profile.nickname
  # else
  #   self.email.split('@').first
  #      #['cohki0305', '@gmail.com']指定した文字で分割して文字列とする
  # end
  #ぼっち演算子
  #profileがnilでなければ.nicknameを行う,
  profile&.nickname || self.email.split('@').first
end

delegate :birthday, :age, :gender, to: :profile, allow_nil: true

# def birthday
#   profile&.birthday
# end

# def gender
#   profile&.gender
# end

def preapre_profile 
  profile || current_user.build_profile
end

def avatar_image
  if profile&.avatar&.attached?#アップロードされているかいないか
    profile.avatar
  else
    'default-avatar.png'
  end
end
end
