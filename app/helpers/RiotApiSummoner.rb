class RiotApiSummoner
    include HTTParty
    base_uri 'https://na1.api.riotgames.com'

    def initialize
        @options = { headers: { "X-Riot-Token": 'RGAPI-6bd52e21-8ce0-46cb-b969-a7135c3fc154' } }
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
