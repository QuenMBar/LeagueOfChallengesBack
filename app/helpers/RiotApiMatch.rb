class RiotApiMatch
    include HTTParty
    base_uri 'https://americas.api.riotgames.com'

    def initialize
        @options = { headers: { "X-Riot-Token": 'RGAPI-884fae2d-d9f7-4570-b9a1-042d8821cc23' } }
    end

    def get_match_details(plat_id, game_id)
        self.class.get("/lol/match/v5/matches/#{plat_id}_#{game_id}", @options)
    end

    def get_match_timeline(plat_id, game_id)
        self.class.get("/lol/match/v5/matches/#{plat_id}_#{game_id}/timeline", @options)
    end
end
