# --------- WELCOME TO MY .tmux.conf ! --------- "
# TPM Plugins {{{
# List of plugins
set -g @plugin 'tmux-plugins/tpm'              # Tmux package manager
set -g @plugin 'tmux-plugins/tmux-sensible'    # "Sensible" default options
set -g @plugin 'tmux-plugins/tmux-sidebar'     # Pressing prefix + ESC shows directory tree
set -g @plugin 'tmux-plugins/tmux-resurrect'   # Restores tmux sessions upon calling tmux
set -g @plugin 'tmux-plugins/tmux-continuum'   # Keeps track of tmux sessions
set -g @plugin 'tmux-plugins/tmux-battery'     # Shows battery status in the status bar 
# }}}
# UI Layout {{{

# Start windows and panes index at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Rather than constraining window size to the maximum size of any client 
# connected to the *session*, constrain window size to the maximum size of any 
# client connected to *that window*. Much more reasonable.
setw -g aggressive-resize on

# Window's name changes according to the process being run on them
set-window-option -g automatic-rename

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

# bind HL to window traversal
bind H select-window -t :-
bind L select-window -t :+

# Change session "opening" directory
bind M attach-session -c "#{pane_current_path}" \; display-message "Change session directory to #{pane_current_path}"

# Create new window with input name.
bind-key C command-prompt -p "Name of new window: " "new-window -n '%%'"

# reload config
bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

# }}}
# Colour scheme {{{

######################
### DESIGN CHANGES ###
######################

# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

#  modes
setw -g clock-mode-colour colour5
setw -g mode-attr bold
setw -g mode-fg colour1
setw -g mode-bg colour18

# panes
set -g pane-border-bg colour0
set -g pane-border-fg colour19
set -g pane-active-border-bg colour0
set -g pane-active-border-fg colour9

# statusbar
set -g status-position bottom
set -g status-justify left
set -g status-bg colour18
set -g status-fg colour137
set -g status-attr dim
set -g status-left ''
set -g status-right '#[fg=colour233,bg=colour8,bold] %H:%M:%S #[fg=colour233,bg=colour19,bold] %d/%m #[fg=red]#{battery_status_bg} Batt: #{battery_icon} #{battery_percentage} #{battery_remain} '
set -g status-right-length 50
set -g status-left-length 20

setw -g window-status-current-fg colour1
setw -g window-status-current-bg colour19
setw -g window-status-current-attr bold
setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour255]#W#[fg=colour249]#F '

setw -g window-status-fg colour9
setw -g window-status-bg colour18
setw -g window-status-attr none
setw -g window-status-format ' #I#[fg=colour237, bold]:#[fg=colour250]#W#[fg=colour244,bold]#F '

setw -g window-status-bell-attr bold
setw -g window-status-bell-fg colour255
setw -g window-status-bell-bg colour1

# messages
set -g message-attr bold
set -g message-fg colour232
set -g message-bg colour16

# Statusline options
set-option -g status-position top # Sets the statusline on the top of the screen.
set -g status-interval 1

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
set -g @resurrect-processes 'vim ssh psql mysql sqlite3 npm android-studio ~ipython'

# Restore pane contents
#set -g @resurrect-capture-pane-contents 'on'

# Restore bash history
#set -g @resurrect-save-shell-history 'on'
# }}}

# Initializes bashrc for every pane
set-option -g default-command "exec /bin/bash"
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
# vim:foldmethod=marker:foldlevel=0
