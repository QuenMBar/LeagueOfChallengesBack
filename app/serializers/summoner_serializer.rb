class SummonerSerializer < ActiveModel::Serializer
    attributes :id, :summoner_id, :account_id, :puuid, :name, :profile_icon_id, :summoner_level, :score
end
