# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_profile = AdminProfile.create(title: 'Administrateur')
guest_profile = AdminProfile.create(title: 'Guest')
User.create(email: 'supports.maintenances@ngser.com', password: 'lotogb21', firstname: 'Supports', lastname: 'Maintenances', msisdn: '2250759243303', profile_id: admin_profile.id)
User.create(email: 'projet@ngser.com', password: 'lotogb21', firstname: '', lastname: 'Projet', msisdn: '2250757462025', profile_id: guest_profile.id)