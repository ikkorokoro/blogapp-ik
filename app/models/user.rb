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
has_many :favorite_articles, through: :likes, source: :article#自分がいいねした記事を習得できるlikesテーブルを通してarticlesテーブルのデータを習得する
has_one :profile, dependent: :destroy

=begin 
＝＝＝＝＝自分がフォローしているユーザーとのralationship＝＝＝＝＝＝
=end
has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
#自分がフォローする。（フォロワー）      外部キーの名前:                クラス名:
has_many :followings, through: :following_relationships, source: :following
#自分がフォロ-したユーザーの情報を取得できる

=begin
＝＝＝＝＝自分をフォローしているユーザーとのralationship＝＝＝＝＝＝
=end
has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship'
#相手が自分をフォローする（フォローされる）
has_many :followers, through: :follower_relationships, source: :follower
#フォローしているユーザーの情報を取得する

#====表示されているarticleが自分が投稿したarticlesに一致するか？=======
def has_written?(article)
  articles.exists?(id: article.id)
end

def has_liked?(article)
  likes.exists?(article_id: article.id)
end
#===フォローするメソッド===
def follow!(user)
  following_relationships.create!(following_id: user.id)
  end
#===フォローを外すメソッド＝＝＝
def unfollow!(user)
  relation = following_relationships.find_by!(following_id: user.id)
  relation.destroy!
end

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

delegate :birthday, :age, :gender, to: :profile, allow_nil: true#allow_nilがボッチ演算子の代わりになる

# def birthday
#   profile&.birthday
# end

# def gender
#   profile&.gender
# end

def prepre_profile
  profile || build_profile
end

def avatar_image
  if profile&.avatar&.attached?#画像がアップロードされているかのメソッド
    profile.avatar
  else
    'default-avatar.png'
  end
end
end
