# Function to expand aliases
globalias() {
    # List of aliases to NOT expand
    local -a skip_aliases=(l ls ll tree)

    # Extract the last word on the current line
    local last_word=${LBUFFER##* }

    # Check if last_word is in the skip_aliases array
    if [[ ${skip_aliases[(i)$last_word]} -le ${#skip_aliases} ]]; then
        zle self-insert
    # If not skipped, check if it's an alias and expand
    elif [[ $LBUFFER =~ '[a-zA-Z0-9._-]+$' ]]; then
        zle _expand_alias
        zle self-insert
    else
        zle self-insert
    fi
}

zle -N globalias # Create the zle widget
bindkey ' ' globalias # Bind the spacebar to the widget
bindkey '^ ' self-insert # Bind Control-Space to just insert a space without expanding
