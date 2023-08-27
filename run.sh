#!/bin/bash

current_dir="$(dirname "$0")"
echo $current_dir

# Exécuter le script create.sh depuis le même répertoire
command="$1"
project_name="$2"
group_id=""
artifact_id=""
webTech=""

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

        echo "========================================"
        echo "Choisissez le framework frontend :"
        echo "1. Vue.js"
        echo "2. React"
        echo "3. Angular"
        read -p "- Entrez le numéro de votre choix : " webTech

        case $webTech in
            1)
                echo "Vous avez choisi Vue.js."
                # Insérez ici les commandes spécifiques pour intégrer Vue.js
                ;;
            2)
                echo "Vous avez choisi React."
                 "$current_dir/Scripts/web/reactConfig.sh" "$project_name"
                ;;
            3)
                echo "Vous avez choisi Angular."
                # Insérez ici les commandes spécifiques pour intégrer Angular
                ;;
            *)
                echo "Choix invalide."
                ;;
        esac
        echo "========================================"
        ;;
    
    *)
        echo "Usage: $0 {make:create}"
        exit 1
        ;;
esac
