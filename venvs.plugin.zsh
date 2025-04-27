export AUTO_VENV_PATH=""
export PROJECT_ROOT=""
export USE_DOTENV=""

[[ "$VENVS_DIR" ]] || export VENVS_DIR="~/.virtualenvs"

function check_venv() {

    if [[ -f .venv/bin/activate ]] || [[ -f venv/bin/activate ]] || [[ -e "$VENVS_DIR/$(basename $(pwd))" ]] ; then
        [[ -f venv/bin/activate ]] && export AUTO_VENV_PATH="$(realpath venv)"
        [[ -f .venv/bin/activate ]] && export AUTO_VENV_PATH="$(realpath .venv)"
        [[ -e "$VENVS_DIR/$(basename $(pwd))" ]] && export AUTO_VENV_PATH="$VENVS_DIR/$(basename $(pwd))"
        source "$AUTO_VENV_PATH/bin/activate" && export PROJECT_ROOT="$(pwd)"
        if [[ "$USE_DOTENV" ]] && [[ -f ".env" ]]; then
            eval `cat .env`
        fi

    else
        if [[ "$PROJECT_ROOT" ]] && (pwd |grep -v "$PROJECT_ROOT" >/dev/null); then
            which deactivate >/dev/null && deactivate
            export AUTO_VENV_PATH=""
            export PROJECT_ROOT=""
        fi
    fi
}

function enable_venvs() {
    autoload -Uz add-zsh-hook
    disable_venvs
    add-zsh-hook chpwd check_venv
}


function disable_venvs() {
    add-zsh-hook -D chpwd check_venv
}


enable_venvs
check_venv
