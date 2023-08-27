#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

project_name="$1"
current_dir="$(pwd)"
config_file="$current_dir/$project_name/.spwConfig"

if [ -f "$config_file" ]; then
    source "$config_file"
    echo "main : $main_path"

    # Poser des questions pour configurer la création du projet React avec TypeScript et/ou Redux
    read -p "Voulez-vous utiliser TypeScript ? (y/n): " use_typescript
    read -p "Voulez-vous utiliser Redux ? (y/n): " use_redux

    # Créer le projet React dans le répertoire main_path
    react_app_name="frontend"  
    cd "$main_path"

    # Options pour create-react-app
    react_app_options="--template "
    if [ "$use_redux" = "y" ] && [ "$use_typescript" = "n" ]; then
        react_app_options="$react_app_options redux"
    elif [ "$use_typescript" = "y" ] && [ "$use_redux" = "n" ]; then
        react_app_options="$react_app_options typescript"
    elif [ "$use_redux" = "y" ] && [ "$use_typescript" = "y" ]; then
        react_app_options="$react_app_options redux-typescript"
    fi

    npx create-react-app "$react_app_name" $react_app_options

else
    echo "Le fichier de configuration $config_file n'existe pas."
fi
