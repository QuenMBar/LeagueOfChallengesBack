class CreatedChallenge < ApplicationRecord
    belongs_to :summoner
    belongs_to :challenge
    belongs_to :champion, optional: true
    belongs_to :item, optional: true
end
