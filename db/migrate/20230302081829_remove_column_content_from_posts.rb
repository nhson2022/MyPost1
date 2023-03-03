class RemoveColumnContentFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :content, :string
  end
end
