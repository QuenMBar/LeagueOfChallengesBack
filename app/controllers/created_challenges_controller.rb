class CreatedChallengesController < ApplicationController
    def destroy
        chal = CreatedChallenge.find(params[:id])
        chal.destroy
        render json: {}
    end

    def create
        s = Summoner.find_by(name: params[:summoner])
        if !s.nil?
            riot_api = RiotApiSummoner.new
            game = riot_api.get_game(s.summoner_id)
            if (game['status'].nil?)
                chal_exist = s.created_challenges.where(game_id: game['gameId']).exists?
                if (!chal_exist)
                    # Parse challenge to pick
                    chal = Challenge.find_by(name: "MVP")

                    cc =
                        CreatedChallenge.create(
                            summoner: s,
                            challenge: chal,
                            attempted: false,
                            game_id: game['gameId'],
                            map_id: game['mapId'],
                            participants_json: game,
                            platform_id: game['platformId'],
                        )

                    # Parse out any replacements
                    if chal.text.include? '<summoner_spell>'
                        game_player = game['participants'].select { |p| p['summonerId'] == s.summoner_id }
                        cc.summoner_spell = game_player[0]['spell1Id']
                        cc.save
                    end

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

    # TODO: Combine these two at somepoint when full crud doesnt matter anymore
    def show
        s = Summoner.find_by(name: params[:id])
        if !s.nil?
            all_chal = s.created_challenges

            render json: all_chal, include: %i[summoner challenge]
        else
            render status: 400
        end
    end

    def update
        s = Summoner.find_by(name: params[:id])
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

            render json: inprogress_chal, include: %i[summoner challenge]
        else
            render status: 400
        end
    end

    private

    def parse_challenges(challenge)
        match_json = JSON.parse(challenge.match_json)
        player = match_json['info']['participants'].select { |p| p['puuid'] == challenge.summoner.puuid }[0]
        participant_id = player['participantId']
        timeline_json = JSON.parse(challenge.timeline_json)
        
        byebug
        
        case challenge.challenge.name
        when "Don't use a Summoner Spell"
            spell_ammount = 0

            if player['summoner1Id'] == challenge.summoner_spell.to_i
                spell_ammount = player['summoner1Casts'].to_i
            elsif player['summoner2Id'] == challenge.summoner_spell.to_i
                spell_ammount = player['summoner2Casts'].to_i
            end

            spell_name = SummonerSpell.find_by(key: challenge.summoner_spell.to_s).name

            if spell_ammount == 0
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You used #{spell_name} 0 times"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status =
                    "You used #{spell_name} #{spell_ammount} times, and you weren't supposed to use #{spell_name} at all"
            end
        when 'Fast Win'
            time_played = match_json['info']['gameDuration'].to_i / 60_000

            if player['win'] == true && time_played <= 25
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You won the game in #{time_played} minutes"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = 'You did not win the game in 25 minutes or less'
            end
        when 'Living Legend'
            
            if player['deaths'] == 0
                challenge.challenge_succeeded = true
                challenge.challenge_status = 'You did it! You stayed alive the entire game'
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = 'You did not win the game without dying'
            end
        when 'Iron Defense'
            inhibs_lost = player['inhibitorsLost']

            if inhibs_lost == 0
                challenge.challenge_succeeded = true
                challenge.challenge_status = 'You did it! You lost 0 turrets'
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You lost #{inhibs_lost} inhibitors"
            end
        when 'No Mercy'
            
            if player['gameEndedInSurrender'] == true && player['win'] == true
                challenge.challenge_succeeded = true
                challenge.challenge_status = 'You did it! You made the enemy team surrender'
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = 'You failed at making the enemy team surrender'
            end
        when 'Good Start'

            if player['firstBloodKill'] == true || player['firstBloodAssist'] == true
                challenge.challenge_succeeded = true
                challenge.challenge_status = 'You did it! You got first blood for your team'
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = 'You failed at getting first blood'
            end
        when 'First Tower'
            
            if player['firstTowerAssist'] == true || player['firstTowerKill'] == true
                challenge.challenge_succeeded = true
                challenge.challenge_status = 'You did it! You got the first tower kill'
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = 'You failed at getting first tower'
            end
        when 'Team Player'
            assists = player['assists'] 

            if assists >= 15
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You got #{assists} assists"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You got #{assists} assists"
            end
        when "Don't purchase a consumable"
            cons_used = player['consumablesPurchased'] 
            
            if cons_used < 0
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You used #{cons_used} consumables"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You used #{cons_used} consumables"
            end
        when "Lee Sin Method Acting"
            wards_placed = player['wardsPlaced'] 
            
            if wards_placed < 0
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You placed #{wards_placed} wards"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You placed #{wards_placed} wards"
            end
        when "All-Seeing Eye"
            wards_placed = player['wardsPlaced'] 
            
            if wards_placed > 25
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You placed #{wards_placed} wards"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You placed #{wards_placed} wards"
            end
        when "Ward Hunter"
            wards_destroyed = player['wardsKilled'] 
            
            if wards_destroyed > 10
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You destroyed #{wards_destroyed} wards"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You destroyed #{wards_destroyed} wards"
            end
        when "Don't get too buff"
            max_health = timeline_json['info']['frames'].max_by { |f| f["participantFrames"][participant_id.to_s]["championStats"]["health"] }["participantFrames"][participant_id.to_s]["championStats"]["health"]
            
            if max_health < 3000
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! Your max health was #{max_health}"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. Your max health was #{max_health}"
            end
        when "Big Baller"
            
            if match_json['info']['participants'].max_by {|p| p['goldSpent']}['puuid'] == challenge.summoner.puuid
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You spent the most gold last game"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You did not spend the most gold last game"
            end
        when "Killionaire"
            
            if match_json['info']['participants'].max_by {|p| p['largestMultiKill']}['puuid'] == challenge.summoner.puuid
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You got the largest Multikill last game"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You did not get the largest Multikill last game"
            end
        when "Punching Bag"
            damage_taken = player['totalDamageTaken']
            
            if match_json['info']['participants'].max_by {|p| p['totalDamageTaken']}['puuid'] == challenge.summoner.puuid
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You took #{damage_taken} damage"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You only took #{damage_taken} damage"
            end
        when "Archmage"
            magic_damage = player['magicDamageDealt']
            
            if match_json['info']['participants'].max_by {|p| p['magicDamageDealt']}['puuid'] == challenge.summoner.puuid
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You dealt #{magic_damage} magic damage"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You dealt #{magic_damage} magic damage"
            end
        when "MVP"
            damage = player['totalDamageDealt']
            
            if match_json['info']['participants'].max_by {|p| p['totalDamageDealt']}['puuid'] == challenge.summoner.puuid
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You dealt #{damage} total damage"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You dealt #{damage} total damage"
            end
        when "Thief"
            stolen_obj = player['objectivesStolen']
            
            if stolen_obj >= 2
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You stole #{stolen_obj} objectives"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You stole less than 2 objectives"
            end
        when "Farm to Win"
            minion_kills = player['totalMinionsKilled']
            
            if minion_kills >= 200
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You killed #{minion_kills} minions"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You killed #{minion_kills} minions"
            end
        when "Try Hard"
            turret_kills = player['turretKills']
            
            if match_json['info']['participants'].max_by {|p| p['turretKills']}['puuid'] == challenge.summoner.puuid
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You destroyed #{turret_kills} turrets"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You destroyed #{turret_kills} turrets"
            end
        when "Serial Killer"
            killing_sprees = player['killingSprees']
            
            if killing_sprees >= 2
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! You had #{killing_sprees} killing sprees"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. You had #{killing_sprees} killing sprees"
            end
        when "Huge Pockets"
            max_gold = timeline_json['info']['frames'].max_by { |f| f["participantFrames"][participant_id.to_s]["currentGold"] }["participantFrames"][participant_id.to_s]["currentGold"]
            
            if max_gold < 3000
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! Your max health was #{max_health}"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. Your max health was #{max_health}"
            end
        when "Glass Cannon"
            armor = timeline_json['info']['frames'].max_by { |f| f["participantFrames"][participant_id.to_s]["championStats"]["armor"] }["participantFrames"][participant_id.to_s]["championStats"]["armor"]
            
            if armor < 100 
                challenge.challenge_succeeded = true
                challenge.challenge_status = "You did it! Your max health was #{max_health}"
            else
                challenge.challenge_succeeded = false
                challenge.challenge_status = "You failed. Your max health was #{max_health}"
            end
        else
            challenge.challenge_succeeded = false
            challenge.challenge_status = 'This challenge never existed, congrats on breaking the game'
        end

        challenge
    end
end
