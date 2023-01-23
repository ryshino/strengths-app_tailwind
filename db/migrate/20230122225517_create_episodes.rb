class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    # user_idに関連付けられたすべてのエピソードを作成時刻の逆順で取り出しやすくする
    add_index :episodes, [:user_id, :created_at]
  end
end
