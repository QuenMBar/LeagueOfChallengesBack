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

Challenge.create(name: "Don't Flash", text: "Don't use your flash all game!", challenge_type: 'overall')
