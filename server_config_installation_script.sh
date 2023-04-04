#!/bin/bash
dotfilesrepo="https://github.com/victoriousace/server_config.git"
repobranch="main"
export name="$(whoami)"

putgitrepo() {
	# Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
	whiptail --infobox "Downloading and installing config files..." 7 60
	[ -z "$3" ] && branch="main" || branch="$repobranch"
	dir=$(mktemp -d)
	[ ! -d "$2" ] && mkdir -p "$2"
	chown "$name":sudo "$dir" "$2"
	sudo -u "$name" git -C "$repodir" clone --depth 1 \
		--single-branch --no-tags -q --recursive -b "$branch" \
		--recurse-submodules "$1" "$dir"
	sudo -u "$name" cp -rfT "$dir" "$2"
}

# Install the dotfiles in the user's home directory, but remove .git dir and
# other unnecessary files.
putgitrepo "$dotfilesrepo" "/home/$name" "$repobranch"
rm -rf "/home/$name/.git/" "/home/$name/README.md" "/home/$name/LICENSE" "/home/$name/FUNDING.yml"
