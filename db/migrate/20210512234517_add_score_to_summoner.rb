class AddScoreToSummoner < ActiveRecord::Migration[6.1]
    def change
        add_column :summoners, :score, :integer
    end
end
