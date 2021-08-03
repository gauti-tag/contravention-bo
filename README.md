# BACK-OFFICE LOTO GUINEE-BISSAU

Cette application est le back-office de la plateforme **_LOTO GUINEE-BISSAU_**.
Ces fonctionnalités éssentielles sont:

* Voir l'historique des transactions (prises de pari, paiements de gains, etc.).
* Les paramétrages fonctionnels applicatif du jeu LOTO.
* La gestion des tirages.
* La gestion des rapports de gain.
* La gestion des utilisateurs back office.
* Piste d’audit.

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
	- *.env* (voir le modèle dans le fichier .example.env)
	- *docker-compose.yml*
- Générer les containers et démarrer les services:
	Les containers peuvent être lancer en utlisant les commandes de **docker-compose**