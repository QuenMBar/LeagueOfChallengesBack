class CreatedChallengeSerializer < ActiveModel::Serializer
    attributes :id,
               :summoner_id,
               :challenge_id,
               :attempted,
               :game_id,
               :map_id,
               :platform_id,
               :challenge_status,
               :challenge_succeeded,
               :champion_id,
               :item_id,
               :summoner_spell,
               :champion_spell,
               :participants_json,
               :match_json,
               :timeline_json
end
