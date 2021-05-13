class LeagueQueueSerializer < ActiveModel::Serializer
  attributes :id, :queueId, :map, :description
end
