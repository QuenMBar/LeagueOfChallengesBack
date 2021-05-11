class AddStatusToCreatedChallenges < ActiveRecord::Migration[6.1]
    def change
        add_column :created_challenges, :challenge_status, :string
        add_column :created_challenges, :challenge_succeeded, :boolean
        rename_column :created_challenges, :completed, :attempted
    end
end
