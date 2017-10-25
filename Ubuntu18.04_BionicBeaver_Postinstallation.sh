#!/bin/bash
# version 0.0.3 (alpha)

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
    exit
    elif  [ "$DISTRIB_RELEASE" != "18.04" ]
    then
        echo "Désolé $SUDO_USER, ce script n'est conçu que pour la 18.04LTS alors que tu es actuellement sur la version $DISTRIB_RELEASE"
        exit
        elif [ "$(which gnome-shell)" != "/usr/bin/gnome-shell" ]
        then
            echo "Bien que tu sois effectivement sur la 18.04 $SUDO_USER, ce script est conçu uniquement pour la version de base sous Gnome-Shell (pour l'instant) alors que tu utilises une variante."
            exit
            else
                echo "Ok, tu as correctement lancé le script, tu es bien sur Bionic avec Gnome-Shell, passons aux questions..."
fi

# Question 1 : sélection du mode de lancement du script
echo "*******************************************************"
echo "1/ Mode de lancement du script : "
echo "*******************************************************"
echo "[1] Mode standard (choix par défaut recommandé pour la plupart des utilisateurs)"
echo "[2] Mode avancé (pour les utilisateurs plus experimentés)"
echo "*******************************************************"
read -p "Répondre par le chiffre correspondant (exemple : 1) : " choixMode
clear

while [ "$choixMode" != "1" ] && [ "$choixMode" != "2" ]
do
    read -p "Désolé, je ne comprend pas ta réponse, c'est soit 1 soit 2, merci de refaire ton choix : " choixMode
    clear
done

echo "======================================================="
echo "Précision : si vous validez directement par 'entrée' au clavier sans mettre de choix, le script considèra que vous avez sélectionné le choix par défaut cad 1 et ceci pour toutes les questions à venir"
# Question 2 : Session 
echo "*******************************************************"
echo "2/ Quelle(s) session(s) supplémentaire(s) souhaites-tu installer ? (plusieurs choix possibles)"
echo "*******************************************************"
echo "[1] Aucune, rester avec la session Ubuntu par défaut (cad Gnome customizé + 2 extensions)"
echo "[2] Ajouter la session 'Gnome Vanilla' (cad une session Gnome non-customizé et sans extension)"
echo "[3] Ajouter la session 'Gnome Classique' (interface plus traditionnelle dans le style de Gnome 2 ou Mate)"
echo "[4] Ajouter la session 'Unity' (l'ancienne interface d'Ubuntu utilisé avant la 17.10"
echo "*******************************************************"
read -p "Répondre par le ou les chiffres correspondants séparés d'un espace (exemple : 2 3) : " choixSession
clear



    

