# Prerequisites

**TODO:** Look into storing SSH keys in 1Password,
and doing away with these prerequisites altogether!
(Or most of them.)

Set up git with your name and email and a new SSH key:

```sh
GITHUB_NAME="Benjamin Wolfe"
GITHUB_EMAIL="bwolfe@plmr.com"
SSH_KEY_FILENAME="github_plmr_macbook"

git config --global user.name "$GITHUB_NAME"
git config --global user.email "$GITHUB_EMAIL"

mkdir -p ~/.ssh
ssh-keygen -t ed25519 -N "" -f ~/.ssh/$SSH_KEY_FILENAME -C "$GITHUB_EMAIL"
echo 'Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/'$SSH_KEY_FILENAME >> ~/.ssh/config
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/$SSH_KEY_FILENAME
pbcopy < ~/.ssh/$SSH_KEY_FILENAME.pub
```

This will copy the key to your clipboard.
Paste it into [GitHub](https://github.com/settings/keys).

While on the page, click "**Configure SSO**" next to the key you just added,
select **PalomarSpecialty**, and use SSO to authorize the key.

Then:

```sh
ssh -o "StrictHostKeyChecking no" -T git@github.com
```

Pull in this repo:

```sh
GH_USERNAME="BenjaminWolfe"

cd ~
git clone git@github.com:$GH_USERNAME/dotfiles.git .dotfiles
cd .dotfiles
git checkout main
git pull
```
