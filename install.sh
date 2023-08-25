#!/bin/bash

# Chemin vers le répertoire où se trouve le script run.sh
script_dir="$(dirname "$0")"

# Vérifier si l'utilisateur utilise Zsh ou Bash
# Vérifier si le fichier de configuration zshrc existe dans le répertoire utilisateur
if [[ -f "$HOME/.zshrc" ]]; then
    shell_rc="zshrc"
else
    shell_rc="bashrc"
fi

# Ajouter l'alias au fichier de configuration du shell
echo "alias spw=\"$script_dir/run.sh\"" >> "$HOME/.$shell_rc"

echo "L'alias 'spw' a été ajouté à votre fichier $shell_rc."

# Charger les modifications du fichier de configuration du shell
source "$HOME/.$shell_rc"

echo "Installation terminée."
