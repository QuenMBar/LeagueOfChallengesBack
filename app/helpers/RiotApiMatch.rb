class RiotApiMatch
    include HTTParty
    base_uri 'https://americas.api.riotgames.com'

    def initialize
        @options = { headers: { "X-Riot-Token": 'RGAPI-9c514bcd-cecd-4d42-9dcb-42543c3ff556' } }
    end

    def get_match_details(plat_id, game_id)
        self.class.get("/lol/match/v5/matches/#{plat_id}_#{game_id}", @options)
    end

    def get_match_timeline(plat_id, game_id)
        self.class.get("/lol/match/v5/matches/#{plat_id}_#{game_id}/timeline", @options)
    end
end
