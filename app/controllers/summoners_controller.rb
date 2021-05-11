class SummonersController < ApplicationController
    def show
        s = Summoner.find_by(name: params[:id])

        if s.nil?
            riot_api = RiotApiSummoner.new
            new_sum = riot_api.summoner(params[:id])
            s =
                Summoner.create(
                    summoner_id: new_sum['id'],
                    account_id: new_sum['accountId'],
                    puuid: new_sum['puuid'],
                    name: new_sum['name'],
                    profile_icon_id: new_sum['profileIconId'],
                    summoner_level: new_sum['summonerLevel'],
                )
        end
        render json: s
    end

    def new_challenges
        s = Summoner.find_by(name: params[:summoner_id])
        if !s.nil?
            riot_api = RiotApiSummoner.new
            game = riot_api.get_game(s.summoner_id)
            if (game['status'].nil?)
                chal_exist = s.created_challenges.where(game_id: game['gameId']).exists?
                if (!chal_exist)
                    cc =
                        CreatedChallenge.create(
                            summoner: s,
                            challenge: Challenge.all.sample,
                            attempted: false,
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
            inprogress_chal = all_chal.where(attempted: false)
            riot_api = RiotApiMatch.new
            inprogress_chal.each do |ic|
                match_details = riot_api.get_match_details(ic['platform_id'], ic['game_id'])
                if (match_details['status'].nil?)
                    match_timeline = riot_api.get_match_timeline(ic['platform_id'], ic['game_id'])
                    ic.attempted = true
                    ic.match_json = match_details
                    ic.timeline_json = match_timeline
                    ic = parse_challenges(ic)
                    ic.save
                end
            end
            all_chal = s.created_challenges

            render json: all_chal, include: %i[summoner challenge]
        else
            render status: 400
        end
    end

    def parse_challenges(challenge)
        case challenge.challenge.name
        when "Don't Flash"
            match_json = JSON.parse(challenge.match_json)
            player = match_json['info']['participants'].select { |p| p['puuid'] == challenge.summoner.puuid }[0]
            flash_ammount = 0
            if player['summoner1Id'] == 4
                flash_ammount = player['summoner1Casts']
            elsif player['summoner2Id'] == 4
                flash_ammount = player['summoner2Casts']
            end

            if flash_ammount == 0
                challenge.challenge_succeeded = true
                challenge.challenge_status = 'You did it, and only flashed 0 times'
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status =
                    "You flashed #{flash_ammount} times, and you werent supposed to flash at all"
            end
        else
            challenge.challenge_succeeded = false
            challenge.challenge_status = 'This challenge never existed, congrats on breaking the game'
        end

        challenge
    end
end
