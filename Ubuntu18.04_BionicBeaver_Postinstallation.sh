#!/bin/bash
# version 0.0.2 (alpha)

# Important : Ce script est en cours de développement, il n'est pas utilisable/testable pour l'instant !
# Warning : This script is under development, it is not usable for the moment !

#  Copyleft 2017 GammaDraconis 
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.


# Contrôle de la configuration système (script correctement lancé + version 18.04 + gnome-shell présent)
. /etc/lsb-release
if [ "$UID" -ne "0" ]
then
    echo "Ce script doit se lancer avec les droits d'administrateur : sudo ./script.sh"
    elif  [ "$DISTRIB_RELEASE" != "18.04" ]
    then
        echo "Désolé $SUDO_USER, ce script n'est conçu que pour la 18.04LTS alors que tu es actuellement sur la version $DISTRIB_RELEASE"
        elif [ "$(which gnome-shell)" != "/usr/bin/gnome-shell" ]
        then
            echo "Bien que tu sois effectivement sur la 18.04 $SUDO_USER, ce script est conçu uniquement pour la version de base sous Gnome-Shell (pour l'instant) alors que tu utilises une variante."
            exit
            else
                echo "Ok, tu as correctement lancé le script, tu es bien sur Bionic avec Gnome-Shell, passons aux questions..."
fi
