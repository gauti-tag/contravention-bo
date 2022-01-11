# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_profile = AdminProfile.create(title: 'Administrateur')
guest_profile = AdminProfile.create(title: 'Guest')
#User.create(email: 'jean.toure@ngser.com', password: 'lotogb21', firstname: 'Jean', lastname: 'TOURE', msisdn: '2250749586809', profile_id: admin_profile.id, account_status: 1)
User.create(email: 'gautiertiehoule_stagiairedti@ngser.com', password: 'contragb21', firstname: 'Gautier', lastname: 'TIEHOULE', msisdn: '225', profile_id: admin_profile.id, account_status: 1)
#User.create(email: 'projet@ngser.com', password: 'lotogb21', firstname: '', lastname: 'Projet', msisdn: '2250757462025', profile_id: guest_profile.id, account_status: 1)