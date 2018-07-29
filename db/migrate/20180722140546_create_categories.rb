class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :image, null: false
      t.string :cover_image, null: false
      t.string :slug, null: false, unique: true

      t.timestamps
    end
    
    reversible do |dir|
      dir.up do
        Category.create_translation_table! :name => { :type => :string, :null => false },
          :description => { :type => :text, :null => false }
      end

      dir.down do
        Category.drop_translation_table!
      end
    end
  end
end
