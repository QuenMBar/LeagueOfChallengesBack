class CreateChampions < ActiveRecord::Migration[6.1]
  def change
    create_table :champions do |t|
      t.string :name
      t.string :key
      t.string :title
      t.string :tags
      t.string :stats

      t.timestamps
    end
  end
end
