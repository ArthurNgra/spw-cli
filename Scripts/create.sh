#!/bin/bash

project_name="$1"
group_id="$2"
artifact_id="$3"

function recap_choices {
    echo "========================================"
    echo "Récapitulatif des choix :"
    echo
    echo "- Nom du projet : $project_name"
    echo "- Identifiant du groupe : $group_id"
    echo "- Identifiant de l'artefact : $artifact_id"
    echo "- Version de Java : $java_version"
    echo "- Outil de construction : $build_tool"
    echo "- Type de packaging : $packaging"
    echo "-Dépendances incluses : $dependencies"
    echo "========================================"
    read -p "Valider les choix (y/n)? " validate_choices
    if [[ $validate_choices =~ ^[Yy]$ ]]; then
        create_project
    else
        start_questions
    fi
}

function create_project {
    echo "Création du projet : $project_name"
    echo "groupId : $group_id"
    echo "artifactId : $artifact_id"
    
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

    eval "$curl_command"
    
    unzip "$project_name.zip" -d "$project_name"
    rm "$project_name.zip"
    
    # Effectuer d'autres actions de configuration si nécessaires
}

function start_questions {
    echo
    echo "===============Parameters================"
    read -p "- Choisissez la version de Java (11, 15, 17, 20): " java_version
    read -p "- Choisissez Maven (m) ou Gradle (g): " build_tool
    read -p "- Choisissez le packaging (War ou Jar): " packaging
    read -p "- Inclure les dépendances web (y/n)? " include_web
    read -p "- Inclure les dépendances devtools (y/n)? " include_devtools
    read -p "- Inclure les dépendances jpa (y/n)? " include_jpa
    read -p "- Inclure les dépendances jdbc (y/n)? " include_jdbc
    read -p "- Inclure les dépendances security (y/n)? " include_security
    echo "========================================"
    echo
    dependencies=""

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

    dependencies=${dependencies%,}

    recap_choices
}

if [ -z "$project_name" ] || [ -z "$group_id" ] || [ -z "$artifact_id" ]; then
    echo "Usage: $0 <project_name> <group_id> <artifact_id>"
    exit 1
fi

start_questions
