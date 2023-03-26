# =============================================================================
#
eval "$(zoxide init zsh)"
#
# =============================================================================

export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS \
    --preview 'lsd --color=always \
    --group-directories-first \
    --oneline {2..}'"
