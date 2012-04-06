class DropMessageRelationship < ActiveRecord::Migration
  def up
  	drop_table :message_relationships
  end

  def down
  end
end
