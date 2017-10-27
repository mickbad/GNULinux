#!/bin/bash
# version 0.0.9 (alpha)

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
echo "3/ Quel(s) navigateur(s) souhaites-tu ? (plusieurs choix possible)"
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

# Messagerie instantannée
echo "*******************************************************"
echo "/ Quel(s) logiciels(s) de messagerie instantannée(s)/tchat(s)/VoIP souhaites-tu ?"
echo "*******************************************************"
echo "[1] Pas de supplément"
echo "[2] Empathy"
echo "[3] Pidgin"
echo "[4] Jitsi"
echo "[5] Psi"
echo "[6] Gajim"
echo "[7] Skype"
echo "[8] Ekiga"
echo "[9] Linphone"
echo "[10] Ring"
echo "[11] Mumble"
echo "[12] TeamSpeak"
echo "[13] Discord"
echo "[14] Tox"
echo "[14] Viber"
echo "[14] Telegram"
echo "[15] Wire"
echo "[16] xChat"
echo "[17] Hexchat"
read -p "Répondre par le ou les chiffres correspondants (exemple : 3 7 13 17)" choixMessagerie
clear

# Download/Upload
echo "*******************************************************"
echo "/ Quel(s) logiciels(s) de téléchargement/copie souhaites-tu ?"
echo "*******************************************************"
echo "[1] Pas de supplément (Transmission installé de base)"
echo "[2] FileZilla (transfert FTP ou SFTP)"
echo "[3] Deluge"
echo "[4] Rtorrent"
echo "[5] qBittorrent"
echo "[6] Utorrent"
echo "[7] Bittorrent"
echo "[8] Vuze (anciennement Azureus)"
echo "[9] aMule (pour le réseau eDonkey2000, clone de Emule)"
echo "[10] FrostWire (client multiplate-forme pour le réseau Gnutella)"
echo "[11] Gtk-Gnutella (un autre client stable et léger avec pas mal d'option)"
echo "[12] EiskaltDC++ (stable et en français, pour le réseau DirectConnect)"
echo "[13] RetroShare (logiciel d'échange basé sur F2F et PGP sécurisé)"
echo "[14] Calypso (client P3P anonyme et évolué)"
echo "[15] Grsync (une interface graphique pour l'outil rsync"
echo "[16] SubDownloader (téléchargement de sous-titre)"
echo "[17] Nicotine+ (client P2P pour le réseau mono-source Soulseek)"
echo "[18] JDownloader (gestionnaire de téléchargement écrit en Java avec beaucoup d'option)"
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3 4 15)" choixTelechargement
clear

# Lecture multimédia
echo "*******************************************************"
echo "4/ Quel(s) logiciels(s) de lecture audio/vidéo/son veux-tu ? (plusieurs choix possible)"
echo "*******************************************************"
echo "[1] Aucun, rester avec Totem comme lecteur vidéo et Rhythmbox comme lecteur audio"
echo "[2] VLC, le couteau suisse de la vidéo !"
echo "[3] MPV, un lecteur léger/puissant capable de lire de nombreux formats mais moins complet que VLC"
echo "[4] SmPlayer, lecteur basé sur mplayer avec une interface utilisant Qt"
echo "[5] Gxine, lecteur vidéo minimaliste écrit en GTK+ basé sur le moteur Xine"
echo "[6] DragonPlayer, un lecteur vidéo plutôt conçu pour l'environnement KDE"
echo "[7] Banshee, un lecteur audio assez complet équivalent à Rhythmbox"
echo "[8] Clementine, lecteur audio avec gestion des pochettes, genres musicaux..."
echo "[9] QuodLibet, un lecteur audio très puissant"
echo "[10] Audacious, lecteur complet avec beaucoup de plugins dispo"
echo "[11] Guayadeque, lecteur audio avec une interface agréable"
echo "[12] Gnome Musique, utilitaire de la fondation Gnome pour la gestion audio"
echo "[13] Gmusicbrowser, lecteur avec interface très configurable"
echo "[14] Musique, un lecteur épuré"
echo "[15] Qmmp, dans le style de Winamp"
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3)" choixMultimedia
clear

# Traitement/montage photo/video/audio
echo "*******************************************************"
echo "4/ Souhaites-tu un logiciel de montage vidéo ?"
echo "*******************************************************"
echo "[1] Non merci (aucun n'est installé par défaut)"
echo "[2] KDEnLive"
echo "[3] OpenShot"
echo "[4] Pitivi"
echo "[5] Lives"
echo "[6] EKD"
echo "[7] Shotcut"
echo "[8] SlowMoVideo"
echo "[9] Flowblade"
echo "[10] Cinelerra"
echo "[11] Natron"
echo "[12] LightWorks"
echo "[13] VLMC (montage vidéo de VideoLan, experimental !)"
echo "[14] Avidemux"
echo "[15] Mencoder"
echo "[16] MkvMerge (gui)"
read -p "Répondre par le ou les chiffres correspondants (exemple : 1)" choixVideo
clear



# Traitement/montage photo/video/audio
echo "*******************************************************"
echo "4/ Quel(s) logiciels(s) de montage photo ou modélisation 3D ?"
echo "*******************************************************"
echo "[1] Aucun"
echo "[2] Gimp"
echo "[3] Krita"
echo "[4] Pinta"
echo "[5] Pixeluvo (propriétaire)"
echo "[6] Phatch"
echo "[7] Cinepaint"
echo "[8] MyPaint"
echo "[9] ImageMagick"
echo "[10] Ufraw"
echo "[11] Inkscape"
echo "[12] sK1"
echo "[13] Xfig"
echo "[14] Darktable"
echo "[15] Art Of Illusion"
echo "[16] Blender"
echo "[17] K-3D"
echo "[18] SweetHome 3D"
echo "[19] LibreCAD"
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 4)" choixGraphisme
clear

# Traitement/montage photo/video/audio
echo "*******************************************************"
echo "4/ Quel(s) logiciels(s) pour l'encodage ou traitement audio ?"
echo "*******************************************************"
echo "[1] Aucun"
echo "[2] Gnome Sound Recorder"
echo "[3] Audacity"
echo "[4] MhWaveEdit"
echo "[5] Flacon"
echo "[6] Sound-Juicer"
echo "[7] RipperX"
echo "[8] Grip"
echo "[9] LMMS"
echo "[10] MiXX"
echo "[11] Ardour"
echo "[12] Rosegarden"
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 4)" choixAudio
clear


# Utilitaires #(a compléter)
echo "*******************************************************"
echo "4/ Quel(s) utilitaire(s) veux-tu ?"
echo "*******************************************************"
echo "[1] Aucun"
echo "[2] Kazam (capture vidéo de votre bureau)"
echo "[3] SimpleScreenRecorder (autre alternative pour la capture vidéo)"
echo "[4] OpenBroadcaster Software (Pour faire du live en streaming, adapté pour les gameurs)"
echo "[5] Glances"
read -p "Répondre par le ou les chiffres correspondants (exemple : 1)" choixUtilitaire
clear

# Gaming
echo "*******************************************************"
echo "4/ Quel(s) jeux-vidéos (ou applis liés aux jeux) installer ?"
echo "*******************************************************"
echo "[1] Aucun, je ne suis pas un gameur"
echo "[2] Steam (portail de jeux)"
echo "[3] PlayOnLinux (permet de faire tourner des jeux Windows via Wine)"
echo "[4] Wine (une sorte d'émulateur pour faire tourner des applis/jeux Windows)"
echo "[5] Minecraft, un des plus célèbres jeux sandbox"
echo "[6] Minetest, un clone de Minecraft mais opensource"
echo "[7] OpenArena, un clone libre de Quake"
echo "[8] 0ad: Empires Ascendant (jeu de stratégie en temps réeel RTS)"
echo "[9] Ryzom (MMORPG sous licence AGPL)"
echo "[10] FlightGear (simulateur de vol)"
echo "[11] SuperTux (clone de Super Mario mais avec un pingouin)"
echo "[12] SuperTuxKart (clone de Super Mario Kart)"
echo "[13] Assault Cube (clone de Counter Strike)"
echo "[14] World Of Padman (jeu de tir basé sur Quake 3 avec des graphismes amusant)"
echo "[15] Second Life (métavers 3D sortie en 2003 sur le modèle f2p)"
echo "[16] Pack 'Gnome Games' comprenant une dizaine de jeux de Gnome"
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3)" choixGaming
clear


## Mode avancé

# Extension  {a modifier.......}
echo "*******************************************************"
echo "A1/ Des extensions Gnome-Shell supplémentaires à installer ?"
echo "*******************************************************"
echo "[1] Non, ne pas ajouter de nouvelles extensions"
echo "[2] AlternateTab : alternative au Alt+Tab issu du mode classique"
echo "[4] Caffeine : permet en 1 clic de désactiver temporairement les mises en veilles"
echo "[5] DashToDock : permet d'avoir + d'option pour les réglages du dock (dock Ubuntu basé dessus)"
echo "[6] DashToPanel : un dock alternatif conçu pour remplacer le panel de Gnome (se place en bas ou en haut)"
echo "[7] Disconnect Wifi : ajoute une option pour déconnecter/reconnecter rapidement le wifi"
echo "[8] Gparte : permet de conserver du contenu copier/coller facilement accessible depuis le panel"
echo "[9] Harddick Led : ajoute un aperçu de l'activité du disque dur"
echo "[10] Hide Activities Button : simplement pour cacher le bouton 'Activités' situé en haut à gauche"
echo "[11] Hide Top Bar : permet de cacher le panel en haut avec nombreux réglages possibles"
echo "[12] Impatience : permet d'augmenter la vitesse d'affichage des animations de Gnome Shell"
echo "[13] Log Out Button : ajouter un bouton de déconnexion pour gagner 1 clic en moins pour cette action"
echo "[14] Media Player Indicator : ajouter un indicateur pour le contrôle du lecteur multimédia"
echo "[15] Move Clock : déplace l'horloge du milieu vers la droite"
echo "[16] Multi monitors add on : ajoute au panel un icone pour gérer rapidement les écrans"
echo "[19] Openweather : Pour avoir la météo directement sur votre bureau"
echo "[21] Places status indicator : Permet d'ajouter un raccourci vers les dossiers utiles dans le panel"
echo "[22] Removable drive menu : Raccourci pour démonter rapidement les clés usb/support externe"
echo "[24] Screenshot windows sizer : Permettre le redimensionnement des fenêtres pour Gnome-Screenshot"
echo "[25] Shortcuts : Permet d'afficher un popup avec la liste des raccourcis possibles"
echo "[27] Suspend button : Ajout d'un bouton pour activer l'hibernation"
echo "[28] Taskbar :..........."
echo "[29] Tilix dropdown : ............"
echo "[31] Taskbar :..........."
echo "[32] Trash : ....."
echo "[33] User themes : ..... "
echo "[34] Window list : ....."
echo "[35] Workspace indicator: ....."
echo "[36] Redshift : ....."
echo "[37] System-monitor: ....."
echo "[38] Window Navigator : ....."
read -p "Répondre par le ou les chiffres correspondants (exemple : 1)" choixExtension
clear

# Prog #(liste a compléter !)
echo "*******************************************************"
echo "A+1/ Pour la programmation/dev web (IDE)..."
echo "*******************************************************"
echo "[1] Pas de supplément (en dehors de Vim)"
echo "[2] Gvim (interface graphique gtk pour Vim)"
echo "[3] Emacs"
echo "[4] Geany"
echo "[5] PyCharm"
echo "[6] Visual Studio Code"
echo "[7] Atom"
echo "[8] Brackets"
echo "[9] Sublime Text"
echo "[10] Code:Blocks"
echo "[11] IntelliJ Idea"
echo "[12] JEdit"
echo "[13] Eclipse"
echo "[14] Anjuta"
echo "[15] Kdevelop"
echo "[16] Android Studio"
echo "[17] Netbeans (EDI supportant plusieurs langage, surtout Java, avec de nombreux plugins)"
read -p "Répondre par le ou les chiffres correspondants (exemple : 4 5)" choixIDE
clear

# Serveur #(liste a compléter !)
echo "*******************************************************"
echo "A+1/ Des fonctions serveurs à activer ?"
echo "*******************************************************"
echo "[1] Pas de service à activer"
echo "[2] Serveur SSH (openssh-server)"
echo "[3] Serveur LAMP (Apache + MariaDB + Php)"
echo "[4] Serveur FTP avec ProFTPd"
echo "[5] Serveur BDD PostgreSQL"
echo "[6] Serveur BDD Oracle"
read -p "Répondre par le ou les chiffres correspondants (exemple : 1)" choixServeur
clear




echo "*******************************************************"
echo "A2/ Des optimisations supplémentaires à activer ?"
echo "*******************************************************"
echo "[1] Non"
echo "[2] Déporter répertoire snappy dans /home pour gagner de l'espace (utile si le /home est séparé et racine limité)"
echo "[3] Swap : régler le swapiness à 5% (le swap sera utilisé uniquement si la ram est utilisé à plus de 95%)"
echo "[4] Désactiver complètement le swap (utile si vous avez un SSD et 8 Go de ram ou +)"
echo "[5] Activer TLP + installer 'Powertop'(économie d'energie pour les pc portable)"
echo "[6] Installer le microcode propriétaire Intel (pour cpu intel uniquement !)"
echo "[7] Ajouter les polices d'écriture Microsoft"
echo "[8] Ajouter un mode 'fraude' à Wayland (permet de lancer sous Wayland par ex Gparted via la commande : fraude gparted)"
echo "[9] Désactiver l'userlist de GDM (utile en entreprise intégré à un domaine)"
echo "[10] Remettre le thème gris d'origine pour GDM (par défaut violet)"
echo "[11] Ajouter Oracle Java"
echo "[12] Installer FlashPlayer pour Firefox (et pour Chromium si installé)"
echo "[13] Ajouter le support pour le système de fichier exFat de Microsoft"
echo "[14] Ajouter le support pour le système de fichier HFS d'Apple"
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3 7)" choixOptimisation
clear


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
         ;;
    esac
done


### Les choses utiles recommandés

# Utilitaires
apt install net-tools vim htop gnome-tweak-tool -y

# Suppression de l'icone Amazon
apt remove ubuntu-web-launchers -y

# Désactivation de l'affichage des messages d'erreurs à l'écran
echo "enabled=0" > /etc/default/apport

