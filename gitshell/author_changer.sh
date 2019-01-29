

# script parse all local branches and rewrite authors

# side-effect:
# will rewrite _update_ time of commits and append ALL commits for whole time
# in your pull-request

git filter-branch --env-filter '
OLD_EMAIL="base@mail.com"
CORRECT_NAME="your_git_name"
CORRECT_EMAIL="your_git_mail"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
