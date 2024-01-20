for file in ~/.dotfiles/source/{path,boot,aliases}/*.sh; do
    [ -r "$file" ] && source "$file"
done

# Add dotfiles bin to final path
export PATH="$HOME/.dotfiles/bin:$PATH"


for file in ~/.dotfiles/source/{path,boot,aliases}/osx/*.sh; do
    [ -r "$file" ] && source "$file"
done
export PATH="$HOME/.dotfiles/bin/osx:$PATH"


