class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :description
      t.integer :user_id
      t.integer :diary_id
      t.timestamps
    end
  end
end
