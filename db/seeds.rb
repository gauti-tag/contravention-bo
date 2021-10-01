# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_profile = AdminProfile.create(title: 'Administrateur')
guest_profile = AdminProfile.create(title: 'Guest')
User.create(email: 'jean.toure@ngser.com', password: 'lotogb21', firstname: 'Jean', lastname: 'TOURE', msisdn: '2250749586809', profile_id: admin_profile.id, account_status: 1)
User.create(email: 'projet@ngser.com', password: 'lotogb21', firstname: '', lastname: 'Projet', msisdn: '2250757462025', profile_id: guest_profile.id, account_status: 1)
Game.create(name: 'NAP 1 FIRST', numbers_limit: 1, rating: 55.0, probability: 90.0, payout_rating: 61.11)
Game.create(name: 'NAP 1', numbers_limit: 1, rating: 11.0, probability: 18.0, payout_rating: 61.11)
Game.create(name: 'NAP 2', numbers_limit: 2, rating: 240.0, probability: 400.0, payout_rating: 60.0)
Game.create(name: 'NAP 3', numbers_limit: 3, rating: 2000.0, probability: 11748.0, payout_rating: 17.02)
Game.create(name: 'NAP 4', numbers_limit: 4, rating: 10000.0, probability: 511038.0, payout_rating: 1.96)
Game.create(name: 'NAP 5', numbers_limit: 5, rating: 40000.0, probability: 43949268.0, payout_rating: 0.09)