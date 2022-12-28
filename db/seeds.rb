# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_profile = AdminProfile.create(title: 'Administrateur')
guest_profile = AdminProfile.create(title: 'Guest')

User.create(email: 'gautier.tiehoule@ngser.com', password: 'contragb22', firstname: 'Gautier', lastname: 'Tiehoule', msisdn: '2250749586809', profile_id: admin_profile.id, account_status: 1)
User.create(email: 'supports.maintenances@ngser.com', password: 'contragb22', firstname: 'Supports', lastname: 'NGSER', msisdn: '2250749586809', profile_id: admin_profile.id, account_status: 1)
User.create(email: 'projet@ngser.com', password: 'contragb22', firstname: 'Projet', lastname: 'NGSER', msisdn: '2250757462025', profile_id: admin_profile.id, account_status: 1)
User.create(email: 'awa.coulibaly@ngser.com', password: 'BAWA2022', firstname: 'Coulibaly', lastname: 'Awa', msisdn: '2250101141422', profile_id: admin_profile.id, account_status: 1)

# Parameter
Parameter.create(name: "Frais contraventions", value: "100", description: "")

# Abilitations
# Admin
AdminAbility.create(title: "Gestion des Utilisateurs", controller_name: "users", action_name: "index", tag: "admin")
AdminAbility.create(title: "Gestion des profiles", controller_name: "users", action_name: "index", tag: "admin")
AdminAbility.create(title: "Piste d'audit", controller_name: "main", action_name: "audit", tag: "admin")
AdminAbility.create(title: "Tableau de bord", controller_name: "main", action_name: "index", tag: "admin")

# Business
AdminAbility.create(title: "Gestion des Classes", controller_name: "groups", action_name: "index", tag: "business")
AdminAbility.create(title: "Gestion des Types", controller_name: "types", action_name: "index", tag: "business")
AdminAbility.create(title: "Gestion des Carnets", controller_name: "notebooks", action_name: "index", tag: "business")
AdminAbility.create(title: "Gestion des Agents", controller_name: "agents", action_name: "index", tag: "business")

# Other
AdminAbility.create(title: "Parametrage", controller_name: "parameters", action_name: "index", tag: "other")
AdminAbility.create(title: "Consultation des Transactions", controller_name: "transactions", action_name: "index", tag: "other")

