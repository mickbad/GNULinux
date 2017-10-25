#!/bin/bash
# version 0.0.5 (alpha)

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

### Section interactive avec les questions

## Mode normale
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
echo "Précision : si tu valides directement par 'entrée' au clavier sans mettre de choix, le script considèra que tu as sélectionné le choix par défaut cad 1 et ceci pour toutes les questions à venir"
# Question 2 : Session 
echo "*******************************************************"
echo "2/ Quelle(s) session(s) supplémentaire(s) souhaites-tu installer ? (plusieurs choix possibles)"
echo "*******************************************************"
echo "[1] Aucune, rester avec la session Ubuntu par défaut (cad Gnome customizé + 2 extensions)"
echo "[2] Ajouter la session 'Gnome Vanilla' (cad une session Gnome non-customizé et sans extension)"
echo "[3] Ajouter la session 'Gnome Classique' (interface plus traditionnelle dans le style de Gnome 2 ou Mate)"
echo "[4] Ajouter la session 'Unity' (l'ancienne interface d'Ubuntu utilisé avant la 17.10)"
echo "*******************************************************"
read -p "Répondre par le ou les chiffres correspondants séparés d'un espace (exemple : 2 3) : " choixSession
clear

# Question 3 : Navigateur web #évidemment des PPA ne sont pas encore actif pour la 18.04 actuellement !! ne pas tester !
echo "*******************************************************"
echo "3/ Quel(s) navigateur(s) voulez-vous ? (plusieurs choix possible)"
echo "*******************************************************"
echo "[1] Pas de navigateur supplémentaire, rester sur la version classique de Firefox (stable)"
echo "[2] Firefox Béta (n+1 cad 1 version d'avance) => attention remplace la version stable !"
echo "[3] Firefox Developper Edition => attention remplace la version stable !"
echo "[4] Firefox ESR => fonctionne indépendamment de la version stable"
echo "[5] Firefox Nightly [Attention instable !] => fonctionne indépendamment de la version stable"
echo "[6] Chromium, la version libre/opensource de Chrome"
echo "[7] Google Chrome, le navigateur propriétaire de Google"
echo "[8] Gnome Web/Epiphany : le navigateur libre de la fondation Gnome"
echo "[9] Midori, un navigateur libre & léger, utilisé notamment sur Elementary OS"
echo "[10] Opera, un navigateur propriétaire relativement connu"
echo "[11] PaleMoon, un navigateur libre & performant"
echo "[12] Vivaldi, un navigateur propriétaire avec une interface sobre"
echo "[13] Falkon/QupZilla, une alternative libre et légère utilisant Webkit"
echo "[14] Tor Browser, pour naviguer dans l'anonymat avec le réseau tor (basé sur Firefox ESR)"
echo "[15] Eolie, une autre alternative pour Gnome [Installation via FlatPak !]"
echo "[16] Min, un navigateur minimaliste très léger"
echo "[17] Rekonq, navigateur utilisant les technologies KDE (déconseillé sous Gnome)"
echo "[18] NetSurf, basique mais très léger et performant"
echo "[19] Dillo, navigateur capable de tourner sur des ordinosaures"
echo "[20] Lynx : s'utilise 100% en ligne de commande, pratique depuis une console SSH"
echo "*******************************************************"
read -p "Répondre par le ou les chiffres correspondants séparés d'un espace (exemple : 6 11 20)" choixNavigateur
clear


## Mode avancé












    

### Section installation automatisé

# Q2/ Installation des sessions demandées
for session in $choixSession
do 
    if [ "$session" = "2" ]
    then 
        apt install gnome-session -y #session vanilla        
    fi
    
    if [ "$session" = "3" ]
    then 
        apt install gnome-shell-extensions -y #session classique  
    fi

    if [ "$session" = "4" ]
    then 
        apt install unity-session -y #session unity      
    fi
done

# Q3/ Installation des navigateurs demandées
for navigateur in $choixNavigateur
do
    case $navigateur in
        "2") #firefox béta
            add-apt-repository ppa:mozillateam/firefox-next -y
            ;;
         "3") #firefox aurora/dev
            add-apt-repository ppa:ubuntu-mozilla-daily/firefox-aurora -y
            ;;
         "4") #firefox esr
            add-apt-repository ppa:jonathonf/firefox-esr -y
            apt update ; apt install firefox-esr -y
            ;;
         "5") #firefox nightly
            add-apt-repository ppa:ubuntu-mozilla-daily/ppa -y 
            apt update ; apt install firefox-trunk -y
            ;;
         "6") #chromium
            apt install chromium-browser -y    
            ;;
         "7") #chrome
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
            sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
            apt update ; apt install google-chrome-stable -y
         ;;
         "8") #epiphany
            apt install epiphany-browser -y
         ;;
         "9") #midori
            add-apt-repository ppa:midori/ppa -y
            apt update ; apt install midori -y
         ;;
         "10") #opera
         #a ajouter.....
         ;;
         "11") #palemoon
         #a ajouter.....
         ;;
         "12") #vivaldi
         #a ajouter.....
         ;;
         "13") #Falkon/Qupzilla
            apt install qupzilla -y
         ;;
         "14") #Tor browser
            apt install torbrowser-launcher -y
         ;;
         "15") #Eolie
         #a ajouter avec flatpak.....
         ;;
         "16") Min
         #a ajouter.....
         ;;
         "17") #Rekonq
         #a ajouter.....
         ;;
         "18") #Netsurf
            apt install netsurf-gtk -y
         ;;
         "19") #Dillo
            apt install dillo -y
         ;;
         "20") #Lynx
            apt install lynx -y
    esac
done
