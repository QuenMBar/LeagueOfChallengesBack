class SummonersController < ApplicationController
    def show
        s = Summoner.where('lower(name) = ?', params[:id].downcase).first

        if s.nil?
            riot_api = RiotApiSummoner.new
            new_sum = riot_api.summoner(params[:id])
            if (new_sum['status'].nil?)
                s =
                    Summoner.create(
                        summoner_id: new_sum['id'],
                        account_id: new_sum['accountId'],
                        puuid: new_sum['puuid'],
                        name: new_sum['name'],
                        profile_icon_id: new_sum['profileIconId'],
                        summoner_level: new_sum['summonerLevel'],
                        score: 100,
                    )
                render json: s
            else
                render json: {}
            end
        else
            render json: s
        end
    end
end
