class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :content

      t.timestamps
    end
    add_index :feedbacks, [:user_id, :created_at]
  end
end
