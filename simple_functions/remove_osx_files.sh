remove_file() {
  if [[ $1 =~ ".DS_Store" ]]; then
    echo "remove: => $path"
    rm -rf $1
  fi
}

for path in $(find . -type f)
do
  remove_file $path
done
