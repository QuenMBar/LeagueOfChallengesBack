# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroy All Tables'

CreatedChallenge.destroy_all
# Summoner.destroy_all
Challenge.destroy_all
# Item.destroy_all
# Champion.destroy_all
# SummonerSpell.destroy_all
# LeagueQueue.destroy_all

puts 'Load in Challenges'

# TAGS: "Mage", "Marksman", "Support", "Tank", "Fighter", "Assassin"

all_challenges = [
    ["Don't use a Summoner Spell", "Don't use your <summoner_spell> all game!", 'overall'], # x
    ["Don't purchase a consumable", "Don't purchase a consumable all game!", 'overall'], # x
    ["Don't use a spell", "Don't use your <champion_spell> all game!", 'overall'],
    ["Don't get too buff", "Don't let your hp exceed 3000!", 'tank'], # x
    ['Fast Win', 'Win a game in 25 minutes or less', 'overall'], # x
    ['Dragon Master', 'Kill 3 dragons as a team', 'overall'], #dragonKills x
    ['Thief', 'Steal 2 objectives', 'jungle'], #objectivesStolen x
    ['Team Player', 'Get 15 or more assists', 'support'], #assists x
    ['Farm to Win', 'Kill over 200 minions', 'marksman'], #totalMinionsKilled x
    ['Baron Shutout', 'Allow the enemy team 0 baron kills', 'overall'], #baronKills
    ['Good Start', 'Get first blood or a first blood assist', 'overall'], #firstBloodKill x
    ['Big Baller', 'Spend more gold than anyone else in the game', 'overall'], #goldSpent x
    ['Lee Sin Method Acting', 'Place 0 wards', 'overall'], #wardsPlaced x
    ['Try Hard', 'Get the most turret kills in a game', 'overall'], #turretKills x
    ['All-Seeing Eye', 'Place 25 wards or more', 'support'], #wordsPlaced x
    ['Killionaire', 'Get the largest multikill', 'overall'], #largestMultiKill x
    ['Punching Bag', 'Take the most damage in the game', 'tank'], #totalDamageTaken x
    ['First Tower', 'Get the first tower kill or assist', 'overall'], #firstTowerKill / firstTowerAssist x
    ['Iron Defense', 'Lose 0 inhibitors', 'overall'], #inhibitorsLost x
    ['No Mercy', 'Make the other team surrender', 'overall'], #gameEndedinSurrender x
    ['Serial Killer', 'Go on 2 or more killing sprees', 'overall'], #killingSprees x
    ['Archmage', 'Deal the most magic damage in the game', 'mage'], #magicDamageDealt x
    ['Living Legend', 'Stay alive the entire game with 0 deaths', 'overall'], #deaths x
    ['Ward Hunter', 'Destroy 10 or more wards', 'overall'], # x
    ['MVP', 'Deal more damage than anyone else', 'overall'], # x
    ['Huge Pockets', 'Have over 2500 gold at anytime during the game', 'overall'], # x
    ['Glass Cannon', 'Never have over 100 armor', 'overall'], # x
]

all_challenges.each { |c| Challenge.create(name: c[0], text: c[1], challenge_type: c[2]) }

# puts 'Load in Champions'

# all_champions = HTTParty.get('http://ddragon.leagueoflegends.com/cdn/11.9.1/data/en_US/champion.json')
# all_champions['data'].each do |c|
#     specific_champ =
#         HTTParty.get("http://ddragon.leagueoflegends.com/cdn/11.9.1/data/en_US/champion/#{c[0]}.json")['data'][c[0]]
#     Champion.create(
#         name: specific_champ['name'],
#         key: specific_champ['key'],
#         title: specific_champ['title'],
#         tags: specific_champ['tags'],
#         stats: specific_champ['stats'],
#         spell_1_name: specific_champ['spells'][0]['name'],
#         spell_2_name: specific_champ['spells'][1]['name'],
#         spell_3_name: specific_champ['spells'][2]['name'],
#         spell_4_name: specific_champ['spells'][3]['name'],
#     )
# end

# puts 'Load in Items'

# all_items = HTTParty.get('http://ddragon.leagueoflegends.com/cdn/11.9.1/data/en_US/item.json')
# all_items['data'].each do |i|
#     mythic_bool = i[1]['description'].include? 'rarityMythic'
#     Item.create(
#         name: i[1]['name'],
#         key: i[0],
#         maps: i[1]['maps'],
#         tags: i[1]['tags'],
#         price: i[1]['gold']['total'],
#         mythic: mythic_bool,
#     )
# end

# puts 'Load in Summoner Spells'

# all_summoner_spells = HTTParty.get('http://ddragon.leagueoflegends.com/cdn/11.9.1/data/en_US/summoner.json')
# all_summoner_spells['data'].each { |s| SummonerSpell.create(name: s[1]['name'], key: s[1]['key']) }

# puts 'Load in Queues'

# all_queues = HTTParty.get('http://static.developer.riotgames.com/docs/lol/queues.json')
# all_queues.each { |q| LeagueQueue.create(queueId: q['queueId'], map: q['map'], description: q['description']) }

puts 'All Done!'
