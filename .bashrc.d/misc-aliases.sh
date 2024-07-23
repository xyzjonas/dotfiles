alias ls="ls -la --color"
alias dlogs="docker logs -f"
alias gs="git status"
alias gl="git log --pretty=oneline --abbrev-commit"

function gdone() {
    masters=( develop main master )
    current_branch=$(git branch --show-current)
    if [[ "${masters[*]}" == *"${current_branch}" ]]; then
            echo "already on $current_branch branch"
            return
    fi
    for branch in "${masters[@]}"
    do
            echo $branch
            if [[ "$(git branch | grep $branch)" ]]; then
            checkout_to=$branch
            break
        fi
    done
    echo $checkout_to
    git checkout $checkout_to
    git branch -D $current_branch
    git pull
}

function ga() {
  git add . || return
  git commit --amend --no-edit || return
  git push -f
}


alias cat="bat"
