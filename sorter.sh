#!/bin/bash
git_dir=$HOME/Development

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

echo "This program will move any and all folders containing a .git file"
echo "It is therefore not a good idea to run it as root, so make sure you aren't,"
echo "unless you know what you're doing."

read -p "Would you like to reallocate your git folders into $git_dir? (Y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    create_and_move
    echo "Finished moving git folders into ${git_dir}"
fi
exit 1
