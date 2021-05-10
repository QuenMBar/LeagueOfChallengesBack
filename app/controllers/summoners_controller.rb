class SummonersController < ApplicationController
    def show
        s = Summoner.find_by(name: params[:id])

        if s.nil?
            riot_api = RiotApiSummoner.new
            newSum = riot_api.summoner(params[:id])
            s =
                Summoner.create(
                    summoner_id: newSum['id'],
                    account_id: newSum['accountId'],
                    puuid: newSum['puuid'],
                    name: newSum['name'],
                    profile_icon_id: newSum['profileIconId'],
                    summoner_level: newSum['summonerLevel'],
                )
        end
        render json: s
    end

    def new_challenges
        s = Summoner.find_by(name: params[:summoner_id])
        if !s.nil?
            riot_api = RiotApiSummoner.new
            game = riot_api.get_game(s.summoner_id)
            if (game['status_code'] != 404)
                chal_exist = s.created_challenges.where(game_id: game['gameId']).exists?
                if (!chal_exist)
                    cc =
                        CreatedChallenge.create(
                            summoner: s,
                            challenge: Challenge.all.sample,
                            completed: false,
                            game_id: game['gameId'],
                            map_id: game['mapId'],
                            participants_json: game['participants'],
                            platform_id: game['platformId'],
                        )
                    render json: cc, include: %i[summoner challenge]
                else
                    current_chal = s.created_challenges.where(game_id: game['gameId'])
                    render json: current_chal, include: %i[summoner challenge]
                end
            else
                render status: 400
            end
        else
            render status: 400
        end
    end

    def all_challenges
        s = Summoner.find_by(name: params[:summoner_id])
        if !s.nil?
            all_chal = s.created_challenges
            inprogress_chal = all_chal.where(completed: false)
            riot_api = RiotApiMatch.new
            inprogress_chal.each do |ic|
                match_details = riot_api.get_match_details(ic['platform_id'], ic['game_id'])
                if (match_details['status_code'] != 404)
                    match_timeline = riot_api.get_match_timeline(ic['platform_id'], ic['game_id'])
                    ic.completed = true
                    ic.match_json = match_details
                    ic.timeline_json = match_timeline
                    ic.save
                end
            end
            all_chal = s.created_challenges

            render json: all_chal, include: %i[summoner challenge]
        else
            render status: 400
        end
    end
end
