class Summoner < ApplicationRecord
    has_many :created_challenges
    has_many :challenges, through: :created_challenges
end
