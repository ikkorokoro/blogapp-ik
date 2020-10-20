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


#====showで表示されているarticleは自分が投稿したarticlesに一致するか？=======
def has_written?(article)
  articles.exists?(id: article.id)
end
#===自分がいいねをしたarticleの中に引数と一致するarticleがあるか？===
def has_liked?(article)
  likes.exists?(article_id: article.id)
end


#＝＝＝＝＝自分がフォローしているユーザーとのralationship(フォロワー)＝＝＝＝＝＝

has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
#自分がフォローする。（フォロワー）      外部キーの名前:                クラス名:
has_many :followings, through: :following_relationships, source: :following
#自分がフォロ-したユーザーの情報を取得できる


#＝＝＝＝＝自分をフォローしているユーザーとのralationship(フォローされる)＝＝＝＝＝＝

has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship'
#相手が自分をフォローする（フォローされる）
has_many :followers, through: :follower_relationships, source: :follower
#フォローしているユーザーの情報を取得する


#===フォローするメソッド===
def follow!(user)
  #==userがUserクラスのインスタンスであるか？is_a?(User)==
    #==userのインスタンスか数字のみが渡される可能性があるため==
  user_id = get_user_id(user)
  following_relationships.create!(following_id: user_id)
  end

#===フォローを外すメソッド＝＝＝
def unfollow!(user)
  #==userがUserクラスのインスタンスであるか？is_a?(User)==
    #==userのインスタンスか数字のみが渡される可能性があるため==
  user_id = get_user_id(user)
  relation = following_relationships.find_by!(following_id: user_id)
  relation.destroy!
end

#===フォローしているユーザーの中に引数と一致するユーザーがいるか？===
def has_followed?(user)
  following_relationships.exists?(following_id: user.id)
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


private
#==userがUserクラスのインスタンスであるか？is_a?(User)==
    #==userのインスタンスか数字のみが渡される可能性があるため==
def get_user_id(user)
  if user.is_a?(User)
    user.id
  else
    user
  end
end
end
