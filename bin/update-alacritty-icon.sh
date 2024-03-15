#maintainer doesn't want to ship a mac icon: https://github.com/alacritty/alacritty/issues/3926
#script taken from here: https://github.com/hmarr/dotfiles/blob/main/bin/update-alacritty-icon.sh

#!/bin/bash

set -eo pipefail

icon_path=/Applications/Alacritty.app/Contents/Resources/alacritty.icns
if [ ! -f "$icon_path" ]; then
  echo "Can't find existing icon, make sure Alacritty is installed"
  exit 1
fi

echo "Backing up existing icon"
hash="$(shasum $icon_path | head -c 10)"
mv "$icon_path" "$icon_path.backup-$hash"

echo "Downloading replacement icon"
icon_url=https://github.com/acoffman/dotfiles/raw/master/misc/Alacritty.icns
curl -sL $icon_url > "$icon_path"

touch /Applications/Alacritty.app
killall Finder
killall Dock
