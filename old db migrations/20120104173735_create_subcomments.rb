class CreateSubcomments < ActiveRecord::Migration
  def change
    create_table :subcomments do |t|
      t.string :content
      t.integer :user_id
      t.integer :comment_id

      t.timestamps
    end
    add_index :subcomments, :user_id
    add_index :subcomments, :comment_id
  end
end
