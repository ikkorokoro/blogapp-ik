# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  has_one_attached :eyecatch#画像はアクティブストレージで管理できるため追加できる
  has_rich_text :content
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100 }
  validates :title, format: { with: /\A(?!\@)/ }#@から始まっていないかチェック

  validates :content, presence: true
  

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

end
