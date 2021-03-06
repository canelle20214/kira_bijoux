# KiraBijoux

## Sommaire

* [Pour demarrer votre serveur Phoenix](#pour-demarrer-votre-serveur-phoenix)
  * [En savoir plus](#en-savoir-plus)
* [Configurer le Back](#configurer-le-back)
  * [Installer Elixir](#installer-elixir)
  * [Installer Phoenix](#installer-phoenix)
  * [Installer PostgreSQL](#installer-postgresql)
  * [Installer nmake pour compiler bcrypt](#installer-nmake-pour-compiler-bcrypt)
* [Infos utiles](#infos-utiles)
  * [Generer le Swagger](#generer-le-swagger)
  * [Generer le schema de la base de donnee (SGBD)](#generer-le-schema-de-la-base-de-donnee-sgbd)
  * [Exemples Erreurs](#exemples-erreurs)
* [Partie Git](#partie-git)
  * [Commandes Git Basique](#commandes-git-basique)
  * [Commandes Git Avancees](#commandes-git-avancees)
  * [Commandes Git Autres](#commandes-git-autres)
* [Partie Deploiement](#partie-deploiement)
  * [Etape 1 (Configuration Heroku)](#etape-1-configuration-heroku)
  * [Etape 2 (Connection)](#etape-2-connection)
  * [Etape 3 (Configurer les Applications)](#etape-3-configurer-les-applications)
  * [Etape 4 (Deployer vos modifications)](#etape-4-deployer-vos-modifications)
  
## Pour demarrer votre serveur Phoenix

- Installez les dépendances avec `mix deps.get`
- Créer et migrer votre base de données avec `mix ecto.setup`
- Installez les dépendances de Node.js avec `npm install` dans le répertoire `assets`
- Démarrez le serveur de Phoenix avec `mix phx.server`

Vous pouvez maintenant visiter [`localhost:4000`](http://localhost:4000) à partir de votre navigateur.

Prêt à entrer en production ? Veuillez [consulter nos guides de déploiement](https://hexdocs.pm/phoenix/deployment.html).

### En savoir plus

- Site officiel: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

## Configurer le Back

### Installer Elixir

  - Source : [Doc installation Elixir](https://bit.ly/3aCqkfG)
  - Tuto : [Doc setup Elixir](https://bit.ly/3mDcA6I)

### Installer Phoenix

  - Source : [Doc installation Phoenix](https://bit.ly/3mMQv5A)
  - Commandes :
    - `mix local.hex`
    - `mix archive.install hex phx_new 1.5.7`

### Installer PostgreSQL

  - Source : [Doc installation Postgresql](https://bit.ly/3mKFmlZ)
  - Tuto : [Doc setup Postgresql](https://bit.ly/3pnqhZj)
  - Username : `postgres` / Password : `postgres`
  - Lancer logiciel Editeur du Registre :
  - Chemin : `Ordinateur\HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.js`
  - Modifier la variable Content Type pour mettre : `text/javascript`
  - Redémarrer votre PC et exécuter pgAdmin4

### Installer nmake pour compiler bcrypt

  - Source 1 : [Forum stackoverflow Elixir](https://bit.ly/3h7wsxs)
  - Source 2 : [Issues github Elixir](https://bit.ly/34yoqsA)

  - Etape 1 ) Installer Visual studio community : [Doc installation VS2019](https://bit.ly/3hcD79E)
  - Au cours de l'installation vous serez redirigé vers Visual Studio Installer et la dessus il faut cocher :
    - Dans l'onglet charge de travail : Développement Desktop en C++
    - Dans l'onglet composants individuels : Outils C++ CMake pour Windows
  - Une fois installé vous devriez avoir un fichier nmake.exe dans votre répertoire d'installation
  - Etape 2 ) Après il faut l'ajout l'ajouter aux variables d'environnements dans la variable Path
  - Vous devez mettre votre chemin d'installation de nmake il devrait ressembler à ça :
    - C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.28.29333\bin
  - Etape 3 ) Et pour finir il y a une suite de commande à exécuter la première compiler bcrypt
    - `cmd /K "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64`
    - `mix compile`
    - `exit`
    - `mix ecto.setup`
    - `mix phx.server`

## Infos utiles

### Generer le Swagger
  - Source : [Doc setup swagger Elixir](https://bit.ly/2M63frD)
  - Commandes :
    - `mix phx.swagger.generate`

### Generer le schema de la base de donnee (SGBD)

  - Etape 1 ) Configurer le Back pour taper sur Mysql plutot que Postgres :
    - Installer [Wamp](https://bit.ly/2YZE39d) pour avoir Phpmyadmin et [Mysql Workbench](https://bit.ly/2Z1wPS4)
    - Récupérer le dossier Config Mysql du repo [Elixir_Phoenix_Projets](https://bit.ly/3rC4gqJ)
    - Modifier les fichiers suivants pour taper sur Mysql :
      - (mix.hex + dev.exs + tests.exs + repo.ex) => en s'inspirant du dossier récupérer précédemment
      - ensuite vous devrez par contre utiliser la dépendance MyXQL plutot que Postgrex 
      - puis rentrer vos informations de connexions de votre phpmyadmin
      - et lancer la commande `mix deps.get` puis `mix ecto.setup` et c'est bon vous avez la bdd
  - Etape 2 ) Générer le SGBD avec Mysql Workbench :
    - se connecter à l'instance de connexion MYSQL avec Mysql Workbench
    - ensuite dans le menu en haut clicker sur Database puis Reverse Engineer
    - puis sélectionner la base de donnée utilisé puis faites valider
    - et réaranger le schéma en vous basant sur l'exemple de la dernière version du SBGD

### Exemples Erreurs

  - Base de données pas à jour :
    - aller dans le gestionnaire des taches et arreter pgadmin 
    - ensuite détruisez votre base de donnée actuelle avec un `mix ecto.drop`
    - puis récréer votre base de donée avec les dernières modifs en faisant un `mix ecto.setup`
  - Erreur de Build : 
    - il faut que vous lancez git bash comme terminal
    - puis commencer par détruire votre dossier build actuelle avec un `rm -rf _build`
    - vous aurez peut etre a avoir à éxécuter `npm deps.get` pour rétélcharger les dépendances
    - puis recréer votre dossier build avec les dernères modifs en faisant un `mix ecto.setup`
  - Champ inconnu en base de donnée :
    - pour la newsletter si il vous manque le champ `cc` en base de donnée
    - vous devrez aller dans le fichier `newsletter.ex`
    - et changer les `:object` par des `:cc` dans le fichier
    - puis il vous faudra resetup la bdd avec un `mix ecto.drop` et un `mix ecto.setup`
    - après celà remettez les `:object` au lieu des `:cc` comme c'était avant 
    - puis refaite un `mix ecto.setup` au cas où 

## Partie Git

### Commandes Git Basique

  |                            Commandes                          |               Explication              |
  |:-------------------------------------------------------------:|:--------------------------------------:|
  | git clone https://github.com/CyrielleGl/kira-bijoux-front.git |           récupère le projet git       |
  |                            git status                         |          vérifie l'état des fichiers   |
  |                            git add .                          |        ajoute les fichiers aux projet  |  
  |                git commit -m "<message_du_commit>"            |        donne un nom à ta sauvegarde    |
  |                      git log --oneline -n 10                  |        liste les dernières sauvegardes |
  |                 git push origin <nom_de_la_branche>           |            envoie ton projet sur git   |
  |                git pull origin <nom_de_la_branche>            |               met à jour le repo       |

### Commandes Git Avancees

  |                            Commandes                          |               Explication              |
  |:-------------------------------------------------------------:|:--------------------------------------:|
  |                            git branch                         |            liste les branches          |
  |                   git checkout <nom_de_la_branche>            |         te positionne sur une branche  |
  |                 git push origin <nom_de_la_branche>           |      envoie ton projet sur la branche  |
  |                        git checkout develop                   |            te positionne sur develop   |
  |                  git merge <nom_de_la_branche>                |        merge ta branche sur develop    |
  |                      git push origin develop                  |        envoie tes modifs sur develop   |

### Commandes Git Autres
  
  |                            Commandes                          |               Explication              |
  |:-------------------------------------------------------------:|:--------------------------------------:|
  |                            git flow init                      |      initialise toutes les branches    |
  |              git flow feature start <nom_de_la_feature>       |       démarre ta branche feature       |
  |                          git fetch origin                     |        récupère l'état des branches    |
  |                         git rebase origin                     |        récupère la source des branches |
  |                          git restore .                        |       annule toutes les modifications  |

## Partie Deploiement

### Etape 1 (Configuration Heroku)

  - Commencer par vous créer un compte sur [Heroku](https://bit.ly/3eJlD49)
  - Ensuite regarder vos mails vous avez du recevoir une invitation d'Heroku 
  - Afin de pouvoir accéder aux apps que j'ai déjà créer
  - Une fois que vous aurez les apps sur votre dashboard Heroku vous devez installer le [CLI de Heroku](https://devcenter.heroku.com/articles/heroku-cli)
    - Si vous êtes sur Windows et que vous avez une erreur pour lancer l'exe 
    - C'est qu'il est bloqué par votre protection Windows 
    - Vous devez alors lancer votre `cmd` en mode Adminsitrateur 
    - Et vous mettre sur le chemin de l'exe avec un `cd Download`
    - Une fois dessus vous pourrez executer l'exe en mettant le nom du fichier à éxécuter 
    - Par exemple la commande `heroku-x64.exe` marche très bien
  - Une fois que votre installation s'est terminée lancer votre terminal favori 
  - Et éxécuter la commande `heroku` dessus ou `heroku --version`
  - Si vous avez bien comme réponse toutes les commandes de heroku 
  - Ainsi que votre version actuelle de Heroku c'est que l'installation c'est bien passé 

### Etape 2 (Connection)

  - Maintenant vous devez vous connecter à votre compte heroku depuis votre terminal
  - Pour cela vous devez taper la commande `heroku login` puis taper n'importe quel lettre sauf `q`
  - Cela devrait ouvrir heroku sur votre navigateur web, vous devez clicker sur login 
  - Une fois cela fait la commande `heroku login` devrait vous retourner comme réponse votre mail

### Etape 3 (Configurer les Applications)

  - Ensuite vous devrez récupérer le code de la dernière version du build de l'application grace à `git`
  - Pour récupérer le code du Back vous devez le cloner : 
    - et éxécuter la commande `heroku git:clone -a frozen-bayou-52604` 
    - et faire un `cd frozen-bayou-52604`
  - Et pour le Front c'est pareil vous devez aussi le cloner : 
    - et éxécuter la commande `heroku git:clone -a secure-gorge-17007` 
    - et faire un `cd secure-gorge-17007`
  - Ensuite vous devez rajouter le Buildpack aux 2 applications
  - Pour le Back vous devez ajouter un buildpack propre à Elixir :
    - pour le rajouter à votre app vous devez faire la commande suivante
    - `heroku buildpacks:set hashnuke/elixir`
  - Pour le Front vous devez rajouter un Buildpack propre à NodeJS :
    - pour le rajouter à votre app vous devez faire la commande suivante
    - `heroku buildpacks:set heroku/nodejs`
  - Et après pour les 2 applications (Front & Back)
  - Vous devez taper la commande `heroku buildpacks` 
  - Afin de vérifier que vous avez bien ajouter le Buildpack pour votre application
  - Maitenant pour configurer la base de donnée vous devrez faire les commandes suivantes
    - `heroku addons:create heroku-postgresql:hobby-dev`
    - `heroku config:set POOL_SIZE=18`
    - `mix phx.gen.secret`
    - `heroku config:set SECRET_KEY_BASE="YOUR_SECRET_GENERATE_KEY_BASE"`

### Etape 4 (Deployer vos modifications)

  - Pour déployer c'est comme avec Gitlab ou Github c'est les memes commandes 
  - Commencer par vérifier que vous avez bien le remote sur vos 2 dossiers clonés 
  - En faisant la commande `git remote -v` et regarder si vous avez le remote de Heroku
  - Ensuite faites vos modifications dans le code source
  - Puis vous devrez les ajouter au projet en faisant un `git add .` et faire un commit 
  - Avec la commande `git commit -m "make it better"` par exemple
  - Puis pour finir déployer vos modifs avec la commande :
    - `git push heroku master` pour le Front 
    - `git push heroku main` pour le Back
  - C'est un peu long cette commande prend au moins 5 minutes à s'éxécuter soyez patients
    - Si vous avez fait des modifs sur les fichiers de migration et donc sur la base de donnée
    - Vous devez alors supprimer la base de donnée actuelle avec un `heroku pg:reset DATABASE`
    - Puis remettez la en place avec un `heroku run "POOL_SIZE=2 mix ecto.migrate"`
    - Soyez bien surs de vous avant d'éxéctuer ces commandes :)