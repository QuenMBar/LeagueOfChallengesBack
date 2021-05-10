class Challenge < ApplicationRecord
    has_many :created_challenges
    has_many :summoners, through: :created_challenges
end
