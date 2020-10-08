# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  birthday     :date
#  gender       :integer
#  introduction :text
#  nickname     :string
#  subscribed   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1, other: 2 }#ハッシュで性別と数字を紐付ける
  belongs_to :user

  def age
    return '不明' unless birthday.present?
    #現在の年を習得する
    years = Time.zone.now.year - birthday.year
    day = Time.zone.now.yday - birthday.year
      if days <  0 
        "#{years - 1}歳"
      else
        "{years}歳"
      end
  end
end
