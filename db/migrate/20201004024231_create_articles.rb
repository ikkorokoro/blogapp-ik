class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false#null: falseオプションは絶対に入っていないと保存できないようにする
      #nul: falseでuser_idとuserが紐付いていないと保存できない
      t.string :title, null: false#string 短い文字列
      t.text :content, null: false #text 長い文字列
      t.timestamps#データの日付を保存するためのカラム
    end
  end
end
