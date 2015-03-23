class AddIndexes < ActiveRecord::Migration
  def up
    add_index :posts, :user_id
    add_index :posts, :topic_id
    add_index :comments, :user_id
  end

  def down
    remove_index :posts, column: :user_id
    remove_index :posts, column: :topic_id
    remove_index :comments, column: :user_id
  end
end
