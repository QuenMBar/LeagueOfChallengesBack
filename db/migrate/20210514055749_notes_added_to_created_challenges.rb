class NotesAddedToCreatedChallenges < ActiveRecord::Migration[6.1]
    def change
        add_column :created_challenges, :notes, :string
    end
end
