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
  * [Infos Utilisateurs deja creer hashes avec Bcrypt](#infos-utilisateurs-deja-creer-hashes-avec-bcrypt)
  * [Exemples Erreurs](#exemples-erreurs)
* [Partie Git](#partie-git)
  * [Commandes Git Basique](#commandes-git-basique)
  * [Commandes Git Avancees](#commandes-git-avancees)
  * [Commandes Git Autres](#commandes-git-autres)
  
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

### Infos Utilisateurs deja creer hashes avec Bcrypt

  - Users de test : 
    - Test => email : test@test.com / password : test 
    - Toto => email : toto@toto.com / password : toto 
    - Tonton => email : tonton@tonton.com / password : tonton 
  - Admin de test :
    - Admin => email : admin@gmail.com / password : admin

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
    - pour la newsletter si il vous manque le champ cc en base de donnée
    - vous devrez aller dans le fichier newsletter.ex
    - et changer les :object par des :cc
    - puis il vous faudra resetup la bdd avec un `mix ecto.drop` et un `mix ecto.setup`
    - après celà remettez les :object au lieu des :cc comme c'était avant et refaite un `mix ecto.setup` au cas où

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
