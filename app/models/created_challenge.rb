class CreatedChallenge < ApplicationRecord
    belongs_to :summoner
    belongs_to :challenge
    belongs_to :champion
    belongs_to :item
end
