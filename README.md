# KiraBijoux

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `npm install` inside the `assets` directory
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

## Configurer Elixir / Phoenix

- Installer Elixir

  - Source : [Doc installation Elixir](https://bit.ly/3aCqkfG)
  - Tuto : [Doc setup Elixir](https://bit.ly/3mDcA6I)

- Installer Phoenix

  - Source : [Doc installation Phoenix](https://bit.ly/3mMQv5A)
  - Commandes :
    - `mix local.hex`
    - `mix archive.install hex phx_new 1.5.7`

- Installer PostgreSQL

  - Source : [Doc installation Postgresql](https://bit.ly/3mKFmlZ)
  - Tuto : [Doc setup Postgresql](https://bit.ly/3pnqhZj)
  - Username : `postgres` / Password : `postgres`
  - Lancer logiciel Editeur du Registre :
  - Chemin : `Ordinateur\HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.js`
  - Modifier la variable Content Type pour mettre : `text/javascript`
  - Redémarrer votre PC et exécuter pgAdmin4

- Installer Swagger
  - Source : [Doc setup swagger Elixir](https://bit.ly/2M63frD)
  - Commandes :
    - `mix phx.swagger.generate`

---

- Installer nmake pour compiler bcrypt

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
    - `mix ecto setup`
    - `mix phx.server`

---

- Infos Utilisateurs déjà créer hashés avec Bcrypt

  - User de test : 
    - Test => email : test@test.com / password : test 
    - Toto => email : toto@toto.com / password : toto 
    - Tonton => email : tonton@tonton.com / password : tonton 
