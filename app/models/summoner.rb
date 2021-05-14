class Summoner < ApplicationRecord
    has_many :created_challenges
    has_many :challenges, through: :created_challenges

    def add_completed
        n = as_json
        n['attempted_challenges'] = created_challenges.count
        n
    end
end
