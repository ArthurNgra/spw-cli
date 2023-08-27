#!/bin/bash

# Fonction pour récupérer le chemin d'un répertoire par son nom
get_directory_path() {
    local config_file=".spwConfig"
    local directory_name="$1"
    
    if [ -f "$config_file" ]; then
        # Charger le fichier de configuration
        source "$config_file"
        
        case "$directory_name" in
            "repository_path")
                echo "$repository_path"
                ;;
            "controller_path")
                echo "$controller_path"
                ;;
            "entity_path")
                echo "$controller_path"
                ;;
            "security_path")
                echo "$controller_path"
                ;;
            "service_path")
                echo "$controller_path"
                ;;
            "group_id")
                echo "$controller_path"
                ;;
            "artifact_id")
                echo "$controller_path"
                ;;
            # Ajoutez d'autres répertoires et chemins au besoin
            *)
                echo "Répertoire inconnu : $directory_name"
                ;;
        esac
    else
        echo "Le fichier de configuration n'existe pas."
    fi
}
