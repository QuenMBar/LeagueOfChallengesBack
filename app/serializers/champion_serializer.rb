class ChampionSerializer < ActiveModel::Serializer
    attributes :id, :name, :key, :title, :tags, :stats, :spell_1_name, :spell_2_name, :spell_3_name, :spell_4_name
end
