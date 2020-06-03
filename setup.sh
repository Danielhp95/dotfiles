# Install distro specific programs
bash ./distro_install_scripts/arch_install.sh

# Create symlinks between config files
bash ./symlink_configs.sh

# Ignoring files globally
git config --global core.excludesfile '~/dotfiles/gitignore_global'
