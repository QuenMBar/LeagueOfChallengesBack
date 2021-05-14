class CreatedChallengeSerializer < ActiveModel::Serializer
    attributes :id,
               :summoner,
               :challenge,
               :attempted,
               :game_id,
               :map_id,
               :platform_id,
               :challenge_status,
               :challenge_succeeded,
               :champion,
               :item,
               :summoner_spell,
               :champion_spell,
               :participants_json,
               :notes
    #    :match_json,
    #    :timeline_json
end
