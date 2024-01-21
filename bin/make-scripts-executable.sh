#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

echo "Making all scripts in bin directories executable..."

# Parse all 'bin' directory from the current directory
find . -type d -name 'bin' | while read dir; do
    echo "Processing: $dir"
    
    # Recherche des fichiers .sh et modification des permissions pour les rendre exécutables
    find "$dir" -type f -name '*.sh' -exec chmod +x {} \;

done

echo "All scripts in bin directories are now executable."
