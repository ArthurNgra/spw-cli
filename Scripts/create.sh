#!/bin/bash

project_name="$1"
group_id="$2"         # Nouvelle variable pour groupId
artifact_id="$3"      # Nouvelle variable pour artifactId

if [ -z "$project_name" ] || [ -z "$group_id" ] || [ -z "$artifact_id" ]; then
    echo "Usage: $0 <project_name> <group_id> <artifact_id>"
    exit 1
fi

echo "Création du projet : $project_name"
echo "groupId : $group_id"
echo "artifactId : $artifact_id"

# Demander à l'utilisateur de choisir la version de Java
read -p "Choisissez la version de Java (11, 15, 17, 20): " java_version

# Demander à l'utilisateur de choisir Maven ou Gradle
read -p "Choisissez Maven (m) ou Gradle (g): " build_tool

# Demander à l'utilisateur de choisir le packaging WAR ou JAR
read -p "Choisissez le packaging (War ou Jar): " packaging

# Demander à l'utilisateur de choisir les dépendances
read -p "Inclure les dépendances web (y/n)? " include_web
read -p "Inclure les dépendances devtools (y/n)? " include_devtools
read -p "Inclure les dépendances jpa (y/n)? " include_jpa
read -p "Inclure les dépendances jdbc (y/n)? " include_jdbc
read -p "Inclure les dépendances security (y/n)? " include_security

dependencies=""

# Valider les réponses
if [[ $include_web =~ ^[Yy]$ ]]; then
    dependencies+="web,"
fi

if [[ $include_devtools =~ ^[Yy]$ ]]; then
    dependencies+="devtools,"
fi

if [[ $include_jpa =~ ^[Yy]$ ]]; then
    dependencies+="data-jpa,"
fi

if [[ $include_jdbc =~ ^[Yy]$ ]]; then
    dependencies+="jdbc,"
fi

if [[ $include_security =~ ^[Yy]$ ]]; then
    dependencies+="security,"
fi

# Supprimer la virgule finale des dépendances
dependencies=${dependencies%,}

# Construire la commande pour créer le projet en utilisant curl
curl_command="curl -G https://start.spring.io/starter.zip -d javaVersion=$java_version  -d artifactId=$artifact_id -d groupId=$group_id -o $project_name.zip "

if [ "$build_tool" = "m" ]; then
    curl_command+=" -d type=maven-project"
else
    curl_command+=" -d type=gradle-project"
fi

if [ "$packaging" = "War" ]; then
    curl_command+=" -d packaging=war"
else
    curl_command+=" -d packaging=jar"
fi

if [ -n "$dependencies" ]; then
    curl_command+=" -d dependencies=$dependencies"
fi

# Exécuter la commande curl
eval "$curl_command"

# Dézipper le projet
unzip "$project_name.zip" -d "$project_name"

# Nettoyer le fichier ZIP
rm "$project_name.zip"

# Effectuer d'autres actions de configuration si nécessaires
