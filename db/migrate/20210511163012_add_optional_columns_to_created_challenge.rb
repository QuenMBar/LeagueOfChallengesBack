class AddOptionalColumnsToCreatedChallenge < ActiveRecord::Migration[6.1]
    def change
        add_column :created_challenges, :summoner_spell, :string
        add_column :created_challenges, :champion_spell, :string
    end
end
