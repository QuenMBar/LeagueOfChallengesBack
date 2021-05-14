class RiotApiSummoner
    include HTTParty
    base_uri 'https://na1.api.riotgames.com'

    def initialize
        @options = { headers: { "X-Riot-Token": 'RGAPI-884fae2d-d9f7-4570-b9a1-042d8821cc23' } }
    end

    def summoner(name)
        name.gsub! ' ', '%20'
        self.class.get("/lol/summoner/v4/summoners/by-name/#{name}", @options)
    end

    def get_game(summon_id)
        summon_id.gsub! ' ', '%20'
        self.class.get("/lol/spectator/v4/active-games/by-summoner/#{summon_id}", @options)
    end
end
