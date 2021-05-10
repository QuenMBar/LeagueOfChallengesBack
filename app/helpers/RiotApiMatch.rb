class RiotApiMatch
    include HTTParty
    base_uri 'https://americas.api.riotgames.com'

    def initialize
        @options = { headers: { "X-Riot-Token": 'RGAPI-9e8503aa-cdbb-452d-824a-ea7a15599095' } }
    end

    def get_match_details(plat_id, game_id)
        self.class.get("/lol/match/v5/matches/#{plat_id}_#{game_id}", @options)
    end

    def get_match_timeline(plat_id, game_id)
        self.class.get("/lol/match/v5/matches/#{plat_id}_#{game_id}/timeline", @options)
    end
end
