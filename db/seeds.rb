# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CreatedChallenge.destroy_all
Summoner.destroy_all
Challenge.destroy_all
Item.destroy_all
Champion.destroy_all
SummonerSpell.destroy_all

all_challenges = [["Don't use <summoner_spell>", "Don't use your <summoner_spell> all game!", 'summoner_spell'], []]

all_challenges.each { |c| Challenge.create(name: c[0], text: c[1], challenge_type: c[2]) }
