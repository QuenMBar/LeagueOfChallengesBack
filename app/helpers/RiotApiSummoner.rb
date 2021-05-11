class RiotApiSummoner
    include HTTParty
    base_uri 'https://na1.api.riotgames.com'

    def initialize
        @options = { headers: { "X-Riot-Token": 'RGAPI-9e8503aa-cdbb-452d-824a-ea7a15599095' } }
    end

    def summoner(name)
        self.class.get("/lol/summoner/v4/summoners/by-name/#{name}", @options)
    end

    def get_game(summon_id)
        self.class.get("/lol/spectator/v4/active-games/by-summoner/#{summon_id}", @options)
    end
end
