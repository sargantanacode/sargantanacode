class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false
      t.references :course, foreign_key: true
      t.integer :type, null: false
      t.integer :status, null: false
      t.string :slug, null: false
      t.string :image
      t.bigint :visit_count, default: 0

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Post.create_translation_table! :title => { :type => :string, :null => false },
          :content => { :type => :text, :null => false },
          :excerpt => { :type => :text, :null => false }
      end

      dir.down do
        Post.drop_translation_table!
      end
    end
  end
end
