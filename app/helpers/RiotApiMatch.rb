class RiotApiMatch
    include HTTParty
    base_uri 'https://americas.api.riotgames.com'

    def initialize
        @options = { headers: { "X-Riot-Token": 'RGAPI-e8446f53-5a5c-4417-9937-ef50601cd43f' } }
    end

    def get_match_details(plat_id, game_id)
        self.class.get("/lol/match/v5/matches/#{plat_id}_#{game_id}", @options)
    end

    def get_match_timeline(plat_id, game_id)
        self.class.get("/lol/match/v5/matches/#{plat_id}_#{game_id}/timeline", @options)
    end
end
