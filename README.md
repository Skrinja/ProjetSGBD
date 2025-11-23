# 🚀 Guide de Démarrage Rapide

Ce projet est une application Electron/Vue.js nécessitant un environnement **Node.js** et une base de données **MySQL**.

### 1. Installation des Pré-requis

* Installez **Node.js** (inclut `npm`).
* Installez le serveur de base de données **MySQL** en local.

---

### 2. Base de Données : Création du Schéma

Avant de démarrer le projet, la structure de la base de données doit être créée.

* Localisez le fichier `script.sql` fourni dans les fichiers du projet.
* Utilisez votre client MySQL (Workbench, DBeaver, etc.) pour **exécuter le contenu de `script.sql`**. Cela créera la base de données et toutes ses tables.

---

### 3. Installation et Configuration du Projet

#### a. Dépendances

Ouvrez votre terminal à la racine du projet et installez les librairies :

```bash
npm install
```

#### b. Fichier d'environnement

* Renommer le fichier `.env.example` en `.env`.
* Éditez le fichier .env et remplacez l'URL de la variable DATABASE_URL par l'URL de connexion à votre base de données locale.

Par exemple :
```
DATABASE_URL=mysql://user:password@localhost:3306/nom_de_la_base
```

### 4. Démarrage de l'Application

Lancez l'application avec la commande suivante :

```bash
npm run start
ou
npm start
```