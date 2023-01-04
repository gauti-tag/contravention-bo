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
# User
AdminAbility.create(title: "Consulation des Utilisateurs", controller_name: "users", action_name: "index", tag: "admin")
AdminAbility.create(title: "Création des Utilisateurs", controller_name: "users", action_name: "create", tag: "admin")
AdminAbility.create(title: "Modification des Utilisateurs", controller_name: "users", action_name: "update", tag: "admin")
AdminAbility.create(title: "Suppression des Utilisateurs", controller_name: "users", action_name: "destroy", tag: "admin")
# Profile
AdminAbility.create(title: "Consultation des profiles", controller_name: "admin_profiles", action_name: "index", tag: "admin")
AdminAbility.create(title: "Création des profiles", controller_name: "admin_profiles", action_name: "create", tag: "admin")
AdminAbility.create(title: "Modification des profiles", controller_name: "admin_profiles", action_name: "update", tag: "admin")
# Audit
AdminAbility.create(title: "Consultation piste d'audit", controller_name: "main", action_name: "audit", tag: "admin")
# Dashbord
AdminAbility.create(title: "Consultation tableau de bord", controller_name: "main", action_name: "index", tag: "admin")

# Business
# Classe
AdminAbility.create(title: "Consultation des Classes", controller_name: "groups", action_name: "index", tag: "business")
AdminAbility.create(title: "Création des Classes", controller_name: "groups", action_name: "create", tag: "business")
AdminAbility.create(title: "Importation des Classes", controller_name: "groups", action_name: "import", tag: "business")
AdminAbility.create(title: "Modification des Classes", controller_name: "groups", action_name: "update", tag: "business")
AdminAbility.create(title: "Suppression des Classes", controller_name: "groups", action_name: "destroy", tag: "business")
# Type
AdminAbility.create(title: "Consultation des Types", controller_name: "types", action_name: "index", tag: "business")
AdminAbility.create(title: "Création des Types", controller_name: "types", action_name: "create", tag: "business")
AdminAbility.create(title: "Importation des Types", controller_name: "types", action_name: "import", tag: "business")
AdminAbility.create(title: "Modification des Types", controller_name: "types", action_name: "update", tag: "business")
AdminAbility.create(title: "Suppression des Types", controller_name: "types", action_name: "destroy", tag: "business")
# Carnet
AdminAbility.create(title: "Consultation des Carnets", controller_name: "notebooks", action_name: "index", tag: "business")
AdminAbility.create(title: "Création des Carnets", controller_name: "notebooks", action_name: "create", tag: "business")
AdminAbility.create(title: "Importation des Carnets", controller_name: "notebooks", action_name: "import", tag: "business")
AdminAbility.create(title: "Modification des Carnets", controller_name: "notebooks", action_name: "update", tag: "business")
AdminAbility.create(title: "Suppression des Carnets", controller_name: "notebooks", action_name: "destroy", tag: "business")
# Agent
AdminAbility.create(title: "Consultation des Agents", controller_name: "agents", action_name: "index", tag: "business")
AdminAbility.create(title: "Création des Agents", controller_name: "agents", action_name: "create", tag: "business")
AdminAbility.create(title: "Importation des Agents", controller_name: "agents", action_name: "import", tag: "business")
AdminAbility.create(title: "Modification des Agents", controller_name: "agents", action_name: "update", tag: "business")
AdminAbility.create(title: "Suppression des Agents", controller_name: "agents", action_name: "destroy", tag: "business")

# Other
AdminAbility.create(title: "Consultation des paramètres", controller_name: "parameters", action_name: "index", tag: "other")
AdminAbility.create(title: "Modification des paramètres", controller_name: "parameters", action_name: "update", tag: "other")
AdminAbility.create(title: "Consultation des Transactions", controller_name: "transactions", action_name: "index", tag: "other")

