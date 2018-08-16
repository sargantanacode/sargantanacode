class AddCommentStatusToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comment_status, :integer, default: 1
  end
end
