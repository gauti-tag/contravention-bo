# BACK-OFFICE CONTRAVENTION GUINÉE

Cette application est le back-office de la plateforme **_CONTRAVENTION GUINEE_**.
Ces fonctionnalités éssentielles sont:

- Voir l'historique des transactions (paiements de contraventions, etc.).
- Les paramétrages fonctionnels MENU USSD
- La gestion des utilisateurs back office.
- Piste d’audit.

## Dépendances:

- [Ruby 2.6.0](https://www.ruby-lang.org/en/)
- [Rails 6.0](https://rubyonrails.org/)
- [PostgreSQL 13](https://www.postgresql.org/)
- [Redis 6](https://redis.io/)
- [Docker](https://www.docker.com/)
- [docker-compose](https://docs.docker.com/compose/)

## Démarrer

Pour démarrer l'application:

- Cloner le dépôt.
- Mettre à jour les fichiers suivants selon l'environnement d'exécution de l'application (`développement`, `preprod`, `production`) :
  - _.env_ (voir le modèle dans le fichier .example.env)
  - _docker-compose.yml_
- Générer les containers et démarrer les services:
  Les containers peuvent être lancer en utlisant les commandes de **docker-compose**

## Livraison && Déploiement

- **déploiement-au-24-11-2022**: Veuillez effectuer ces actions après le déploiement:
  - Exécution de fichier de migration en attente: `$ bundle exec rails db:migrate`
  - Exécution du fichier seed.rb pour insertion en base : `$ bundle exec rails db:seed`
