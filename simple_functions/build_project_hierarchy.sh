#!bin/bash

# variables
tmp_root_path="./Projects"


# routes

mkdir $tmp_root_path

# root -> config
mkdir "$tmp_root_path/_config"

mkdir "$tmp_root_path/_config/scripts"
mkdir "$tmp_root_path/_config/scripts/gitignore"
mkdir "$tmp_root_path/_config/scripts/shells"

mkdir "$tmp_root_path/_config/utils"
mkdir "$tmp_root_path/_config/utils/webservers"

mkdir "$tmp_root_path/_config/keys"
mkdir "$tmp_root_path/_config/keys/pseudorsa" # ssh oldest keys
mkdir "$tmp_root_path/_config/keys/pseudorsa/configs" # ssh configs

# root -> presets
mkdir "$tmp_root_path/_presets"
mkdir "$tmp_root_path/_presets/templates"
mkdir "$tmp_root_path/_presets/templates/project_templates"
mkdir "$tmp_root_path/_presets/libs"

# root -> _tmp
mkdir "$tmp_root_path/_tmp"
mkdir "$tmp_root_path/_tmp/_isolated"
mkdir "$tmp_root_path/_tmp/_isolated/_sandbox"

# root -> Fullstack
mkdir "$tmp_root_path/Fullstack"

mkdir "$tmp_root_path/Fullstack/Backend"
mkdir "$tmp_root_path/Fullstack/Backend/Node"
mkdir "$tmp_root_path/Fullstack/Backend/Ruby"
mkdir "$tmp_root_path/Fullstack/Backend/Java"
mkdir "$tmp_root_path/Fullstack/Backend/Python"
mkdir "$tmp_root_path/Fullstack/Backend/Python/ML"

mkdir "$tmp_root_path/Fullstack/Frontend"
mkdir "$tmp_root_path/Fullstack/Frontend/Basic"
mkdir "$tmp_root_path/Fullstack/Frontend/Basic/Learning"
mkdir "$tmp_root_path/Fullstack/Frontend/Basic/Projects"

mkdir "$tmp_root_path/Fullstack/Frontend/Advanced"
mkdir "$tmp_root_path/Fullstack/Frontend/Advanced/React"
mkdir "$tmp_root_path/Fullstack/Frontend/Advanced/Angular"

# root -> Software (outside of web)
mkdir "$tmp_root_path/Software"
mkdir "$tmp_root_path/Software/C"
mkdir "$tmp_root_path/Software/Java"
mkdir "$tmp_root_path/Software/iOS"
mkdir "$tmp_root_path/Software/iOS/Swift/_feautureApps"
mkdir "$tmp_root_path/Software/iOS/Swift/_playground"
mkdir "$tmp_root_path/Software/iOS/Objc/_playground"
mkdir "$tmp_root_path/Software/iOS/Objc/_playground"

# root -> Games
mkdir "$tmp_root_path/Games"

# root -> Teams
mkdir "$tmp_root_path/Teams"
mkdir "$tmp_root_path/Teams/pavbox_archive"

# root -> Work
mkdir "$tmp_root_path/Work"
mkdir "$tmp_root_path/Work/Company"
mkdir "$tmp_root_path/Work/Another"
mkdir "$tmp_root_path/Work/Outsource"

# root -> University
mkdir "$tmp_root_path/University"
mkdir "$tmp_root_path/University/Labs"
mkdir "$tmp_root_path/University/Outsource"

make_keep() {
  echo "this file needs for keeping empty folders" > $1/.gitkeep
}

remove_file() {
  rm -rf $1
}

for path in $(find $tmp_root_path);
do
  if ! [ "$(ls -A $path)" ]; then
    make_keep $path
  fi
done

# clear .gitkeep files

case $1 in
  -r | --remove-keeps)
    for path in $(find $tmp_root_path -type f)
    do
      remove_file $path
    done
    ;;
  *)
    ;;
esac
