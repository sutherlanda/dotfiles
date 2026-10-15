#!/bin/bash
set -e

# macOS preferences. Safe to re-run; each line sets one value.
# Some changes only take effect after logging out and back in.

[ "$(uname)" = "Darwin" ] || exit 0

echo "Applying macOS preferences..."

# Keyboard: fast key repeat, and repeat instead of the accent popup when
# holding a key (needed for hjkl in vim)
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15
defaults write -g ApplePressAndHoldEnabled -bool false

# Typing: no smart quotes/dashes or autocorrect mangling code in text fields
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Finder: show hidden files, all extensions, path and status bars
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Don't litter network and USB volumes with .DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Screenshots: own folder, PNG, no drop shadow
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# Dock: no recent apps
defaults write com.apple.dock show-recents -bool false

killall Finder Dock SystemUIServer 2>/dev/null || true
echo "Done. Log out and back in for keyboard changes to apply everywhere."
