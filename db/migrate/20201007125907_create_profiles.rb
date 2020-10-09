class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false
      t.string :nickname
      t.text :introduction
      t.integer :gender#なぜ性別が数字かというと0か１かで区別した方がプログラムはすぐに判別することができる
      t.date :birthday
      t.boolean :subscribed, default: false#メールの通知
      t.timestamps
    end
  end
end
