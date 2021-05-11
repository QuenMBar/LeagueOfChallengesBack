class AddChampSpellNames < ActiveRecord::Migration[6.1]
    def change
        add_column :champions, :spell_1_name, :string
        add_column :champions, :spell_2_name, :string
        add_column :champions, :spell_3_name, :string
        add_column :champions, :spell_4_name, :string
    end
end
