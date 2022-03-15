#!/bin/bash
git_dir=$HOME/GitRepositories

create_and_move() {
    mkdir -p $git_dir
    git_files=()
    echo "Looking for folders and files . . ."
    while IFS= read -d $'\0' -r file ; do
        git_files=("${git_files[@]}" "$file")
    done < <(find $HOME -type d -name ".git" -print0 2>/dev/null)
    echo "Found ${#git_files[@]} folders"

    echo "Relocating folders and files . . ."
    for folder in ${git_files[@]}
    do
        mv -n $(dirname ${folder[@]}) $HOME/GitRepositories 2>/dev/null
    done
}

create_and_move
echo "Finished moving git folders into ${git_dir}"
exit 1