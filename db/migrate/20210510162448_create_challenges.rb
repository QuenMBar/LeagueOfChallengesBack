class CreateChallenges < ActiveRecord::Migration[6.1]
    def change
        create_table :challenges do |t|
            t.string :name
            t.string :text
            t.string :challenge_type
            t.string :helpers

            t.timestamps
        end
    end
end
