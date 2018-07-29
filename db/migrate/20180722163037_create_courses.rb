class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :image
      t.string :slug, null: false, unique: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Course.create_translation_table! :name => { :type => :string, :null => false },
          :description => { :type => :text, :null => false }
      end

      dir.down do
        Course.drop_translation_table!
      end
    end
  end
end
