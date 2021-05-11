class AddRelationships < ActiveRecord::Migration[6.1]
    def change
        add_reference :created_challenges, :champion, foreign_key: { to_table: :champions }
        add_reference :created_challenges, :item, foreign_key: { to_table: :items }
    end
end
