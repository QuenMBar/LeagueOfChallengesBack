class ChangeGameIdToBeBigIntInCreatedChallenge < ActiveRecord::Migration[6.1]
    def change
        change_column :created_challenges, :game_id, :bigint
    end
end
