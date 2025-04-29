Automatically switches virtualenvs. Supports both venvs in project folder(~/myproject/venv) and in global folder(like ~/.virtualenvs)

Installation in oh-my-zsh
```
git clone "https://github.com/pawnhearts/venvs.git" "$ZSH_CUSTOM/plugins/venvs"
```
Then add venvs to plugins in .zshrc

Configuration variables(add to .zshrc)
```
export VENVS_DIR="~/.virtualenvs"
export USE_DOTENV=""
```

Don't use dotenv feature - use specialized zsh plugin. It was a quick hack and unsafe.

