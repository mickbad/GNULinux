# Script de post-installation pour un système GNU/Linux

_Readme en cours de rédaction_

## Usage


Aide
$ ./pyGnyPostInstall --help

Automatic configuration detection
$ sudo ./pyGnuPostInstall.py

Specific execution with a specific configuration file
$ sudo ./pyGnuPostInstall.py /path/to/config.yml

All automatical configuration are in path ./conf/ and are yaml format
Be careful, name of file must be in lower case

Examples:
        for Ubuntu 17.10: ubuntu-17.10.yaml
        for Xubuntu 17.04: ubuntu-17.04.yaml


## Particularité

Téléchargement du script sans la configuration est possible. Lors du lancement, si la configuration n'est pas trouvé en local, il va la chercher en ligne sur le dépot git
TODO: mettre la bonne url dans le script constante "REMOTE_CONFIG_PATH"


