#!/bin/bash

current_dir="$(dirname "$0")"
echo $current_dir

# Exécuter le script create.sh depuis le même répertoire
command="$1"
project_name="$2"
group_id=""
artifact_id=""

case "$command" in
    make:create)
        if [ -z "$project_name" ]; then
            echo "Usage: $0 make:create <project_name>"
            exit 1
        fi
        echo "===============Project=================="
        # Demander à l'utilisateur de saisir le groupId
        read -p "- Entrez le groupId : " group_id

        # Demander à l'utilisateur de saisir le artifactId
        read -p "- Entrez le artifactId : " artifact_id
        echo "========================================"
        # Appel au script create.sh avec le nom du projet, groupId et artifactId en paramètres
        "$current_dir/Scripts/create.sh" "$project_name" "$group_id" "$artifact_id"
        ;;
    *)
        echo "Usage: $0 {make:create}"
        exit 1
        ;;
esac
