class CreateCreatedChallenges < ActiveRecord::Migration[6.1]
    def change
        create_table :created_challenges do |t|
            t.belongs_to :summoner, null: false, foreign_key: true
            t.belongs_to :challenge, null: false, foreign_key: true
            t.boolean :completed
            t.integer :game_id
            t.integer :map_id
            t.string :participants_json
            t.string :match_json
            t.string :timeline_json

            t.timestamps
        end
    end
end
