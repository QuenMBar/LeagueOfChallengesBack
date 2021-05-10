class ChampionSerializer < ActiveModel::Serializer
  attributes :id, :name, :key, :title, :tags, :stats
end
