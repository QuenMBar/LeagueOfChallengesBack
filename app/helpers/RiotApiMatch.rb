class RiotApiMatch
    include HTTParty
    base_uri 'https://americas.api.riotgames.com'

    def initialize
        @options = { headers: { "X-Riot-Token": 'RGAPI-db2e1a36-7efc-4366-a069-9602d4ac54f7' } }
    end

    def get_match_details(plat_id, game_id)
        self.class.get("/lol/match/v5/matches/#{plat_id}_#{game_id}", @options)
    end

    def get_match_timeline(plat_id, game_id)
        self.class.get("/lol/match/v5/matches/#{plat_id}_#{game_id}/timeline", @options)
    end
end
