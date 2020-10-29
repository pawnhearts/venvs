export AUTO_VENV_PATH=""
export PROJECT_ROOT=""
export USE_DOTENV=""
export OLD_ENV=``

[[ "$VENVS_DIR" ]] || export VENVS_DIR="~/.virtualenvs"

function check_venv() {
    if [[ -f .venv ]] || [[ -f venv/bin/activate ]] || [[ -e "$VENVS_DIR/$(basename $(pwd))" ]]; then
        [[ -f .venv ]] && export AUTO_VENV_PATH="$(cat .venv)"
        [[ -f venv/bin/activate ]] && export AUTO_VENV_PATH="$(realpath venv)"
        [[ -e "$VENVS_DIR/$(basename $(pwd))" ]] && export AUTO_VENV_PATH="$VENVS_DIR/$(basename $(pwd))"
        source "$AUTO_VENV_PATH/bin/activate" && export PROJECT_ROOT="$(pwd)" || export PROJECT_ROOT=""
        if [[ "$USE_DOTENV" ]] && [[ -f ".env" ]]; then
            export OLD_ENV=`env`
            eval `cat .env`
        fi

    else
        if [[ "$PROJECT_ROOT" ]] && pwd |grep "$PROJET_ROOT" >/dev/null; then
            which deactivate >/dev/null && deactivate
            export AUTO_VENV_PATH=""
            export PROJECT_ROOT=""
            [[ "$OLD_ENV" ]] && eval $OLD_ENV
            export OLD_ENV=``
        fi
    fi
}

function enable_autoswitch_virtualenv() {
    autoload -Uz add-zsh-hook
    disable_autoswitch_virtualenv
    add-zsh-hook chpwd check_venv
}


function disable_autoswitch_virtualenv() {
    add-zsh-hook -D chpwd check_venv
}


enable_autoswitch_virtualenv
check_venv
