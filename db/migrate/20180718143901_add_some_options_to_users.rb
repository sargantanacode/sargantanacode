class AddSomeOptionsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bio, :text
    add_column :users, :github, :string
    add_column :users, :linkedin, :string
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :job, :integer
    add_column :users, :name, :string
  end
end
