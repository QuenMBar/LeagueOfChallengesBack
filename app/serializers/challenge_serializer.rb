class ChallengeSerializer < ActiveModel::Serializer
    attributes :id, :name, :text, :challenge_type, :helpers
end
