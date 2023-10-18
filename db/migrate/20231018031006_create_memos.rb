class CreateMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :memos do |t|
      t.string :name, null: false
      t.text :content
      t.integer :search_count, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps

      t.index [:user_id, :name], unique: true
    end
  end
end
