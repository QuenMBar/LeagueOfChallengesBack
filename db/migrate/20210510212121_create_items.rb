class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :key
      t.string :maps
      t.string :tags
      t.boolean :mythic

      t.timestamps
    end
  end
end
