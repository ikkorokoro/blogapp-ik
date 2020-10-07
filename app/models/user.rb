# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
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

def has_written?(article)
  articles.exists?(id: article.id)
end

def display_name#emialの＠より前の部分を習得してそれをアカウント名とする
  self.email.split('@').first
  #['cohki0305', '@gmail.com']指定した文字で分割して文字列とする
end
end
