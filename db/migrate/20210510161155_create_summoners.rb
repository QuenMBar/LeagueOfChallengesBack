class CreateSummoners < ActiveRecord::Migration[6.1]
    def change
        create_table :summoners do |t|
            t.string :summoner_id
            t.string :account_id
            t.string :puuid
            t.string :name
            t.integer :profile_icon_id
            t.integer :summoner_level

            t.timestamps
        end
    end
end
