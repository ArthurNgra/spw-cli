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
    echo "Nom du projet : $project_name"
    echo "Identifiant du groupe : $group_id"
    echo "Identifiant de l'artefact : $artifact_id"
    echo "Chemin du répertoire Repository : $repository_path"
    echo "Chemin du répertoire Service : $service_path"
    echo "Chemin du répertoire Security : $security_path"
    echo "Chemin du répertoire Entity : $entity_path"
    echo "Chemin du répertoire Controller : $controller_path"
else
    echo "Le fichier de configuration $config_file n'existe pas."
fi
