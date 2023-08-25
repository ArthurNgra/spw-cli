#!/bin/bash

# Récupérer le répertoire du script d'installation
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Chemin complet vers le script run.sh
run_script_path="$script_dir/run.sh"

# Nom de l'alias à créer
alias_name="spw"

# Chemin du fichier de configuration du shell
bash_rc_file="$HOME/.bashrc"
zsh_rc_file="$HOME/.zshrc"

# Ajouter l'alias à la configuration du shell bash
echo "alias $alias_name='$run_script_path'" >> "$bash_rc_file"

# Ajouter l'alias à la configuration du shell zsh
echo "alias $alias_name='run_script_path'" >> "$zsh_rc_file"

# Charger la nouvelle configuration du shell (bash)
source "$bash_rc_file"

# Charger la nouvelle configuration du shell (zsh)
source "$zsh_rc_file"

echo "Script spw installé avec succès et alias configuré."
