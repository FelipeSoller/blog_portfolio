class AddPostStatusToBlogs < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :status, :integer, default: 0
  end
end
