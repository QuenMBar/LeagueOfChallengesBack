class CreateLeagueQueues < ActiveRecord::Migration[6.1]
  def change
    create_table :league_queues do |t|
      t.integer :queueId
      t.string :map
      t.string :description

      t.timestamps
    end
  end
end
