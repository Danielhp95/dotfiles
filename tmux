# --------- WELCOME TO MY .tmux.conf ! --------- "
# TPM Plugins {{{
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-sidebar'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
# }}}
# UI Layout {{{

# Start windows and panes index at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Show clock
set-window-option -g clock-mode-colour green #green

# Rather than constraining window size to the maximum size of any client 
# connected to the *session*, constrain window size to the maximum size of any 
# client connected to *that window*. Much more reasonable.
setw -g aggressive-resize on

# Window's name changes according to the process being run on them
set-window-option -g automatic-rename

# Statusline options
set-option -g status-position top # Sets the statusline on the top of the screen.
set -g status-interval 1
set -g status-justify centre # center align window list
set -g status-left-length 20
set -g status-right-length 140
set -g status-left '#[fg=green]#H #[fg=black]• #[fg=green,bright]#(uname -r | cut -c 1-6)#[default]'
set -g status-right '#[fg=green,bg=default,bright]#(tmux-mem-cpu-load) #[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d " " | cut -f 1 -d ",") #[fg=white,bg=default]%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d'

# }}}
# Key mappings {{{
#
# Set window split
bind-key v split-window -h
bind-key b split-window

# PREFIX mapping
set-option -g prefix C-a
bind-key C-a last-window


# Vi copypaste mode (TODO)
set-window-option -g mode-keys vi
bind-key -t vi-copy 'v' begin-selection
bind-key -t vi-copy 'y' copy-selection

# hjkl pane traversal (vim)
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Change session "opening" directory
bind M attach-session -c "#{pane_current_path}" \; display-message "Change session directory to #{pane_current_path}"

# Create new window with input name.
bind-key C command-prompt -p "Name of new window: " "new-window -n '%%'"

# reload config
bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

# }}}
# Colour scheme {{{

# Allow for 256 color terminal
set -g default-terminal "screen-256color"

# # https://github.com/seebi/tmux-colors-solarized/blob/master/tmuxcolors-256.conf
# Sets statusline colours (bar on the bottom)
set-option -g status-bg colour235 #base02
set-option -g status-fg colour136 #yellow
set-option -g status-attr default

# default window title colors
set-window-option -g window-status-fg colour244 #base0
set-window-option -g window-status-bg default

# active window title colors
set-window-option -g window-status-current-fg colour166 #orange
set-window-option -g window-status-current-bg default
set-window-option -g window-status-current-attr bright

# pane border
set-option -g pane-border-fg colour235 #base02
set-option -g pane-active-border-fg colour240 #base01

# message text
set-option -g message-bg colour235 #base02
set-option -g message-fg colour166 #orange

# pane number display
set-option -g display-panes-active-colour colour33 #blue
set-option -g display-panes-colour colour166 #orange

# }}}
# Miscelaneous {{{

# Allows to use the mouse for various actions such as scrolling or changing active pane.
set-option -g mouse on

# Allows for faster key repetition. Don't wait for new keys to be pressed.
set -s escape-time 0


# Activity monitoring
# Allows tmux to check if there is any activity (change) in any window/pane
setw -g monitor-activity on
set -g visual-activity on

# }}}
# PLUGIN: tmux-continuum {{{

# Continuum auto restore
set -g @continuum-restore 'on'
# }}}
# PLUGIN: tmux-resurrect {{{

# Restore vim sessions
set -g @resurrect-strategy-vim 'session'
set -g @resurrect-strategy-vim 'session'
set -g @resurrect-processes 'vim ssh psql mysql sqlite3 npm android-studio ~ipython'
# }}}
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
# vim:foldmethod=marker:foldlevel=0
