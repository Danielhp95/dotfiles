import os

def copy(src, dest):
    os.system('cp ' + src + ' ' + dest)

copy('./vimrc', '~/.vimrc')
copy('./bashrc', '~/.bashrc')
copy('./tmux', '~/.tmux.conf')
