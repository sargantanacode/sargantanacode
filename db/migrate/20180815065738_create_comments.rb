class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :post, foreign_key: true, null: false
      t.integer :parent_id
      t.integer :status, default: 1
      t.string :author, null: false
      t.string :email, null: false
      t.string :url
      t.string :ip
      t.text :comment, null: false

      t.timestamps
    end
  end
end
