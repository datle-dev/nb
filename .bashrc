nbx() {
    local command="$1"
    shift

    case "$command" in
        w)
            _nbx_weekly "$@"
            ;;

        m)
            _nbx_meeting "$@"
            ;;

        f)
            _nbx_fzf "$@"
            ;;

        *)
            echo "nbx - nb extensions"
            echo
            echo "usage:"
            echo "  nbx w[eekly]"
            echo "  nbx m[eeting]"
            echo "  nbx f[zf]"
            ;;
    esac
}

_nbx_weekly() {
    # Creates new weekly file in the weekly folder if it doesn't exist
    # Edits the existing weekly file if it does exist
    local week
    week="$(date +'%G-W%V').md"

    if nb show home:"weekly/$week" >/dev/null 2>&1; then
        nb edit home:"weekly/$week"
    else
        nb add home:"weekly/$week" \
            --template "$HOME/.nb/home/templates/weekly.md"
    fi
}

_nbx_meeting() {
    # Creates a new meeting file with template in the meetings folder
    nb add home:"meetings/$week" \
        --template "$HOME/.nb/home/templates/meeting.md"
}


# _nbx_fzf() {
#     local note
#     note="$(nb --recursive | fzf --height=80% --layout=reverse --border)" || return
#     nb edit "$note"
# }

_nbx_fzf() {
    local f
    f="$(rg --files ~/.nb/home -g '*.md' |
        fzf --preview 'bat --color=always {}' --preview-window='right:60%')" || return

    [ -n "$f" ] && nb edit "$f"
}
