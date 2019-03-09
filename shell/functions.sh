function gpx {
    #is branch name passed?
    if [ "$1" != "" ]; then
        ###take branch name & repo name & company/user
        URL=`git remote get-url origin`
        A="$(cut -d':' -f2 <<< $URL)"
        COMPANY="$(cut -d'/' -f1 <<< $A)"
        B="$(cut -d'/' -f2 <<< $A)"
        REPO="$(cut -d'.' -f1 <<< $B)"

        ###checkout to branch
        git checkout -b $1
        ###push branch and set upstream
        git push --set-upstream origin $1

        ###construct url Pull Request
        PR="https://github.com/$COMPANY/$REPO/compare/$1?expand=1"

        ###open Pull Request
        xdg-open "$PR"

        return 1
    else
        ###take branch name
        BRANCH=`git rev-parse --abbrev-ref HEAD`

        if [ "$BRANCH" = "master" ]; then
            echo "never push from --master--"
            return 1
        fi

        ###take repo name & company/user
        URL=`git remote get-url origin`
        A="$(cut -d':' -f2 <<< $URL)"
        COMPANY="$(cut -d'/' -f1 <<< $A)"
        B="$(cut -d'/' -f2 <<< $A)"
        REPO="$(cut -d'.' -f1 <<< $B)"

        ###push branch and set upstream
        git push --set-upstream origin $BRANCH

        ###construct url Pull Request
        PR="https://github.com/$COMPANY/$REPO/compare/$BRANCH?expand=1"

        ###open Pull Request
        xdg-open "$PR"

        return 1
    fi
}

function pr {
    ###take branch name & repo name & company/user
    BRANCH=`git rev-parse --abbrev-ref HEAD`
    URL=`git remote get-url origin`
    A="$(cut -d':' -f2 <<< $URL)"
    COMPANY="$(cut -d'/' -f1 <<< $A)"
    B="$(cut -d'/' -f2 <<< $A)"
    REPO="$(cut -d'.' -f1 <<< $B)"
    ###construct url Pull Request
    PR="https://github.com/$COMPANY/$REPO/compare/$BRANCH?expand=1"
    ###open Pull Request
    xdg-open "$PR"

    return 1
}

function gpsu {
    ###take branch
    BRANCH=`git rev-parse --abbrev-ref HEAD`
    git push --set-upstream origin $BRANCH

    return 1
}
