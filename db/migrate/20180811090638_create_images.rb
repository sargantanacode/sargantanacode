class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Image.create_translation_table! :title => { :type => :string, :null => false },
          :description => { :type => :text, :null => false }
      end

      dir.down do
        Image.drop_translation_table!
      end
    end
  end
end
