class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title#string 短い文字列
      t.text :content #text 長い文字列
      t.timestamps#データの日付を保存するためのカラム
    end
  end
end
