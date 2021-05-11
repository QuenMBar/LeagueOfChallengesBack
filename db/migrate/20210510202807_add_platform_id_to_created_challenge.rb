class AddPlatformIdToCreatedChallenge < ActiveRecord::Migration[6.1]
    def change
        add_column :created_challenges, :platform_id, :string
    end
end
