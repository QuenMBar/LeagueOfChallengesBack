class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :key, :maps, :tags, :mythic
end
