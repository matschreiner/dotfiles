# shellcheck shell=bash
# Custom Theme - shows cwd instead of program name in window tabs
# Based on default theme

if patched_font_in_use; then
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
else
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'235'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'255'}
# shellcheck disable=SC2034
TMUX_POWERLINE_SEG_AIR_COLOR=$(air_color)

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

# shellcheck disable=SC2128
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_STYLE" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(format regular)"
	)
fi

# MIDDLE - Active window: shows cwd basename instead of #W (program name)
# shellcheck disable=SC2128
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_CURRENT" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
		"#[$(format inverse)]"
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR"
		" #I#F "
		"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN"
		" #{b:pane_current_path} "
		"#[$(format regular)]"
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR"
	)
fi

# Inactive windows: shows cwd basename instead of #W (program name)
# shellcheck disable=SC2128
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_FORMAT" ]; then
    TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
        "#[$(format regular)]"
        "$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN"
        " #I#{?window_flags,#F, } "
        "$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN"
        " #{b:pane_current_path} "
    )
fi

# shellcheck disable=SC1143,SC2128
if [ -z "$TMUX_POWERLINE_LEFT_STATUS_SEGMENTS" ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
        "tmux_session_info 148 234"
		"vcs_branch 29 88"
        "vcs_compare 60 255"
        "vcs_staged 64 255"
        "vcs_modified 9 255"
        "vcs_others 245 0"
	)
fi

# shellcheck disable=SC1143,SC2128
if [ -z "$TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS" ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		"pwd 89 211"
	)
fi
