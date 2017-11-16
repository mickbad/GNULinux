#!/bin/bash
# version 0.0.38 (alpha)

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

# Legende
# <!!> : problème actuellement avec le dépot lors d'un rafraichissement avec apt update
# <i!> : demande intervention de la part de l'utilisateur (install pas entièrement automatisé)
# <l!> : lien précis de la version pour l'installation, peux potentiellement poser problème sur le long terme si le lien change
# <d!> : attention, beaucoup de dépendance Kde !

# Contrôle de la configuration système (script correctement lancé + version 18.04 + gnome-shell présent)
. /etc/lsb-release
if [ "$UID" -ne "0" ]
then
    echo "Ce script doit se lancer avec les droits d'administrateur : sudo ./script.sh"
    exit
    elif  [ "$DISTRIB_RELEASE" != "18.04" ]
    then
        echo "Désolé $SUDO_USER, ce script n'est conçu que pour la 18.04LTS alors que vous êtes actuellement sur la version $DISTRIB_RELEASE"
        exit
        elif [ "$(which gnome-shell)" != "/usr/bin/gnome-shell" ]
        then
            echo "Bien que vous soyez effectivement sur la 18.04 $SUDO_USER, ce script est conçu uniquement pour la version de base sous Gnome-Shell (pour l'instant) alors que vous utilisez une variante."
            exit
            else
                echo "Ok, vous avez correctement lancé le script, vous êtes bien sur Bionic avec Gnome-Shell, passons aux questions..."
                echo -e "#########################################################"
                echo "Légende : "
                echo "[Snap] => Le paquet s'installera de manière isolé avec Snappy (snap install...)"
                echo "[Flatpak] => Le paquet s'installera avec Flatpak, une autre alternative à Snappy"
                echo "[Appimage] => Paquet AppImage téléchargé, pour l'utiliser il faudra le lancer manuellement (pas de raccourci)"
                echo "Si rien de précisé en encadré => Installation classique depuis les dépots officiels si c'est possible sinon PPA"
                echo -e "#########################################################\n"
fi
### Section interactive avec les questions

## Mode normale
# Question 1 : sélection du mode de lancement du script
echo "*******************************************************"
echo "1/ Mode de lancement du script : "
echo "*******************************************************"
echo "[0] Mode novice (lancement automatique sans question avec des choix de logiciels pour les débutants)"
echo "[1] Mode standard (choix par défaut, pose divers questions simples, recommandé pour la plupart des utilisateurs)"
echo "[2] Mode avancé (comme standard mais avec des questions supplémentaires : programmation, optimisation, extension...)"
echo "[3] Mode extra (comme avancé mais avec un supplément snap/flatpak/appimages proposé à la fin)"
echo "*******************************************************"
read -p "Répondre par le chiffre correspondant (exemple : 1) : " choixMode
clear

while [ "$choixMode" != "0" ] && [ "$choixMode" != "1" ] && [ "$choixMode" != "2" ] && [ "$choixMode" != "3" ]
do
    read -p "Désolé, je ne comprend pas votre réponse, les seuls choix possibles sont 1 (novice), 2 (standard), 3 (avancé), 4 (extra) : " choixMode
    clear
done

if [ "$choixMode" != "0" ] #lancement pour tous sauf mode novice
then
    echo "======================================================="
    echo "Précision : si vous validez directement par 'entrée' au clavier sans mettre de choix, le script considèra que vous avez sélectionné le choix par défaut cad 1 et ceci pour toutes les questions à venir"
    # Question 2 : Session 
    echo "*******************************************************"
    echo "2/ Quelle(s) session(s) supplémentaire(s) souhaitez-vous installer ? (plusieurs choix possibles)"
    echo "*******************************************************"
    echo "[1] Aucune, rester avec la session Ubuntu par défaut (cad Gnome customizé + 2 extensions)"
    echo "[2] Ajouter la session 'Gnome Vanilla' (cad une session Gnome non-customizé et sans extension)"
    echo "[3] Ajouter la session 'Gnome Classique' (interface plus traditionnelle dans le style de Gnome 2 ou Mate)"
    echo "[4] Ajouter la session 'Unity' (l'ancienne interface d'Ubuntu utilisé avant la 17.10)"
    echo "*******************************************************"
    read -p "Répondre par le ou les chiffres correspondants séparés d'un espace (exemple : 2 3) : " choixSession
    clear

    # Question 3 : Navigateur web 
    echo "*******************************************************"
    echo "3/ Quel(s) navigateur(s) vous intéresses ? (plusieurs choix possibles)"
    echo "*******************************************************"
    echo "[1] Pas de navigateur supplémentaire : rester sur la version classique de Firefox (stable)"
    echo "[2] Firefox Béta (n+1 : 1 version d'avance, remplace la version classique)"
    echo "[3] Firefox Developer Edition [Flatpak] (n+2 et inclue des outils pour les devs)"
    echo "[4] Firefox ESR (version plutôt orienté entreprise/organisation)"
    echo "[5] Firefox Nightly [Flatpak] (toute dernière build construite, parfois n+3, potentiellement instable !)"
    echo "[6] Chromium (la version libre/opensource de Chrome)"
    echo "[7] Google Chrome <!!> (le célèbre navigateur de Google mais il est propriétaire !)"
    echo "[8] Gnome Web/Epiphany (navigateur de la fondation Gnome s'intégrant bien avec cet environnement)"
    echo "[9] Midori (libre & léger, utilisé notamment par défaut sur la distribution 'Elementary OS')"
    echo "[10] Opera [Demande Interv!] (un navigateur propriétaire relativement connu)"
    echo "[11] PaleMoon <l!> (un navigateur plutôt récent, libre & performant)"
    echo "[12] Vivaldi (un navigateur propriétaire avec une interface sobre assez particulière)"
    echo "[13] Falkon/QupZilla (une alternative libre et légère utilisant Webkit)"
    echo "[14] Tor Browser (pour naviguer dans l'anonymat avec le réseau tor : basé sur Firefox ESR)"
    echo "[15] Eolie [Flatpak](une autre alternative pour Gnome)"
    echo "[16] Min <l!> (un navigateur minimaliste et donc très léger)"
    echo "[17] Rekonq <d!> (Navigateur de Kde, déconseillé sous Gnome !)" 
    echo "[18] NetSurf (basique mais très léger et performant)"
    echo "[19] Dillo (navigateur capable de tourner sur des ordinosaures)"
    echo "[20] Lynx (navigateur 100% en ligne de commande, pratique depuis une console SSH)"
    echo "*******************************************************"
    read -p "Répondre par le ou les chiffres correspondants séparés d'un espace (exemple : 6 11 20) : " choixNavigateur
    clear

    # Question 4 : Messagerie instantannée
    echo "*******************************************************"
    echo "4/ Quel(s) logiciels(s) de courrier ou messagerie instantannée/tchat/VoIP/visio souhaitez-vous ?"
    echo "*******************************************************"
    echo "[1] Aucun"
    echo "[2] Empathy (messagerie instantanné adapté à Gnome, multi-protocole)"
    echo "[3] Pidgin (une alternative à Empathy avec l'avantage d'être multi-plateforme)"
    echo "[4] Jitsi (anciennement 'SIP Communicator' surtout orienté VoIP)"
    echo "[5] Psi (multiplateforme, libre et surtout conçu pour le protocole XMPP cad Jabber)"
    echo "[6] Gajim (un autre client Jabber utilisant GTK+)"
    echo "[7] Skype (logiciel propriétaire de téléphonie, vidéophonie et clavardage très connue)"
    echo "[8] Ekiga (anciennement 'Gnome Meeting', logiciel de visioconférence/VoIP)"
    echo "[9] Linphone (visioconférence utilisant le protocole SIP)"
    echo "[10] Ring (anciennement 'SFLphone', logiciel très performant pour la téléphonie IP)"
    echo "[11] Mumble (logiciel libre connue chez les gameurs pour les conversations audios à plusieurs)"
    echo "[12] TeamSpeak [Demande Interv!] [NE FONCTIONNE PAS : Ne pas sélectionner !]"
    echo "[13] Discord [Snap] (logiciel propriétaire multiplateforme pour communiquer à plusieurs pour les gameurs)"
    echo "[14] qTox [NE FONCTIONNE PAS : Ne pas sélectionner !]"
    echo "[15] Viber [Flatpak] (logiciel de communication, surtout connue en application mobile)"
    echo "[16] Telegram [Snap] (appli de messagerie basée sur le cloud avec du chiffrage)"
    echo "[17] Wire (un autre client de messagerie instantanée chiffré crée par Wire Swiss)"
    echo "[18] Hexchat (client IRC, fork de xchat)"
    echo "[19] Signal [Flatpak & Experimental] (Messagerie instantannée crypté recommandé par Edward Snowden)"
    echo "[20] Polari (client IRC pour Gnome)"
    echo "[21] Slack [Flatpak] (plate-forme de communication collaborative propriétaire avec gestion de projets)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 3 7 13 17) : " choixMessagerie
    clear

    # Question 5 : Download/Upload
    echo "*******************************************************"
    echo "5/ Quel(s) logiciels(s) de téléchargement/copie voulez-vous ?"
    echo "*******************************************************"
    echo "[1] Pas de supplément ('Transmission' installé de base)"
    echo "[2] FileZilla (logiciel très répendu utilisé pour les transferts FTP ou SFTP)"
    echo "[3] Deluge (client BitTorrent basé sur Python et GTK+)"
    echo "[4] Rtorrent (client BitTorrent en ligne de commande donc très léger)"
    echo "[5] qBittorrent (client BitTorrent léger développé en C++ avec Qt)"
    echo "[6] Bittorrent (client non-libre qui s'utilise depuis le terminal via btdownloadgui)"
    echo "[7] Vuze [Snap][Pour Xorg uniquement!] (Plate-forme commerciale d'Azureus avec BitTorrent)"
    echo "[8] aMule (pour le réseau eDonkey2000, clone de Emule)"
    echo "[9] FrostWire (client multiplate-forme pour le réseau Gnutella)"
    echo "[10] Gtk-Gnutella (un autre client stable et léger avec pas mal d'option)"
    echo "[11] EiskaltDC++ (stable et en français, pour le réseau DirectConnect)"
    echo "[12] RetroShare [NE FONCTIONNE PAS : Ne pas sélectionner !]"
    echo "[13] Calypso/Kommute (client P3P anonyme et évolué, à lancer depuis la cli)"
    echo "[14] Grsync (une interface graphique pour l'outil rsync"
    echo "[15] SubDownloader (téléchargement de sous-titre)"
    echo "[16] Nicotine+ (client P2P pour le réseau mono-source Soulseek)"
    echo "[17] Gydl [Flatpak] (permet de télécharger des vidéos Youtube ou juste la piste audio)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3 4 15) : " choixTelechargement
    clear

    # Question 6 : Lecture multimédia
    echo "*******************************************************"
    echo "6/ Quel(s) logiciels(s) de lecture audio/vidéo (ou de stream) voulez-vous ?"
    echo "*******************************************************"
    echo "[1] Aucun, rester avec les choix par défaut ('Totem' pour la vidéo, 'Rhythmbox' pour la musique)"
    echo "[2] VLC VideoLan (le couteau suisse de la vidéo, très complet !)"
    echo "[3] MPV/Gnome MPV (léger et puissant, capable de lire de nombreux formats)" #(semble instable dans une VM)
    echo "[4] SmPlayer (lecteur basé sur mplayer avec une interface utilisant Qt)"
    echo "[5] Gxine [NE FONCTIONNE PAS : Ne pas sélectionner !]"
    echo "[6] DragonPlayer [Attention : beaucoup de dépendance !] (lecteur vidéo KDE)" 
    echo "[7] Banshee (lecteur audio assez complet équivalent à Rhythmbox)"
    echo "[8] Clementine (lecteur audio avec gestion des pochettes, genres musicaux...)"
    echo "[9] QuodLibet (un lecteur audio très puissant avec liste de lecture basé sur les expressions rationnelles)"
    echo "[10] Audacious (lecteur complet pour les audiophiles avec beaucoup de plugins)"
    echo "[11] Guayadeque (lecteur audio et radio avec une interface agréable)"
    echo "[12] Gnome Music (utilitaire de la fondation Gnome pour la gestion audio, assez basique)"
    echo "[13] Gmusicbrowser (lecteur avec une interface très configurable)"
    echo "[14] Musique (un lecteur épuré)"
    echo "[15] Qmmp (dans le même style de Winamp pour les fans)"
    echo "[16] Xmms2+Gxmms2 (un autre lecteur audio dans le style de Winamp)"
    echo "[17] Lollypop [Flatpak] (lecture de musique adapté à Gnome avec des fonctions très avancées)"
    echo "[18] Spotify [Flatpak] (Permet d'accéder gratuitement et légalement à de la musique en ligne)"
    echo "[19] MuseScore [Flatpak] (l'éditeur de partitions de musique le plus utilisé au monde !)"
    echo "[20] Gnome Twitch (pour visionner les flux vidéo du site Twitch depuis votre bureau sans utiliser de navigateur)"
    echo "[21] GRadio [Flatpak] (Application Gnome pour écouter la radio, plus de 1 000 référencés rien qu'en France !)"
    echo "[22] Molotov.TV [Appimage] (Service français de distribution de chaînes de TV)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3) : " choixMultimedia
    clear

    # Question 7 : Traitement/montage video
    echo "*******************************************************"
    echo "7/ Souhaitez-vous un logiciel de montage/encodage vidéo ?"
    echo "*******************************************************"
    echo "[1] Non merci (aucun n'est installé par défaut)"
    echo "[2] Handbrake (transcodage de n'importe quel fichier vidéo)"
    echo "[3] WinFF (encodage vidéo rapide dans différents formats)"
    echo "[4] Libav-tools (fork de FFmpeg, outil en CLI pour la conversion via : avconv)"
    echo "[5] KDEnLive (éditeur vidéo non-linéaire pour monter sons et images avec effets spéciaux)"
    echo "[6] OpenShot Video Editor (une autre alternative comme éditeur vidéo, libre et écrit en Python)"
    echo "[7] Pitivi (logiciel de montage basique avec une interface simple et intuitive)" 
    echo "[8] Lives (Dispose des fonctionnalités d'éditions vidéo/son classique, des filtres et multipiste"
    echo "[9] Shotcut [NE FONCTIONNE PAS : Ne pas sélectionner !]"
    echo "[10] SlowMoVideo [NE FONCTIONNE PAS : Ne pas sélectionner !]"
    echo "[11] Flowblade [Pour Xorg uniquement!] (Logiciel de montage video multi-piste performant)"
    echo "[12] Cinelerra (montage non-linéaire sophistiqué, équivalent à Adobe première, Final Cut et Sony Vegas"
    echo "[13] Natron (programme de post-prod destiné au compositing et aux effets spéciaux)"
    echo "[14] LightWorks [A tester sur une MP]"
    echo "[15] Avidemux [Appimage] (Équivalent de 'VirtualDub' : coupe, filtre et ré-encodage)"
    echo "[16] Mencoder (s'utilise en ligne de commande : encodage de fichier vidéo)"
    echo "[17] MMG : MkvMergeGui (interface graphique pour l'outil mkmerge : création/manipulation fichier mkv)"
    echo "[18] DeVeDe (Création de DVD/CD vidéos lisibles par des lecteurs de salon)"
    echo "[19] Jahshaka [NE FONCTIONNE PAS : Ne pas sélectionner !]"
    echo "[20] Peek [Snap][Pour Xorg uniquement!][A tester sur MP](Outil de création de Gif animé à partir d'une capture vidéo)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 1) : " choixVideo
    clear

    # Question 8 : Traitement/montage photo & modélisation 3D
    echo "*******************************************************"
    echo "8/ Quel(s) logiciels(s) de montage photo ou modélisation 3D ?"
    echo "*******************************************************"
    echo "[1] Aucun (pas de logiciel par défaut)"
    echo "[2] Gimp (montage photo avancé, équivalent à 'Adobe Photoshop')"
    echo "[3] Krita (outil d'édition et retouche d'image, orienté plutôt vers le dessin bitmap)"
    echo "[4] Pinta (graphisme simple équivalent à Paint.NET)"
    echo "[5] Pixeluvo (une autre alternative à Photoshop mais il reste propriétaire)"
    echo "[6] Phatch (pour traiter des images par lot via des scripts prédéfinis)"
    echo "[7] MyPaint (logiciel de peinture numérique développé en Python)"
    echo "[8] Ufraw (logiciel de dérawtisation capable de lire/interpréter la plupart des formats RAW)"
    echo "[9] Inkscape (Logiciel spécialisé dans le dessin vectoriel, équivalent de 'Adobe Illustrator')"
    echo "[10] Darktable (gestionnaire de photos libre sous forme de table lumineuse et chambre noir)"
    echo "[11] Blender (suite libre de modélisation 3d, matériaux et textures, d'éclairage, d'animation...)"
    echo "[12] K-3D (Animation et modélisation polygonale et modélisation par courbes)"
    echo "[13] SweetHome 3D [affichage à tester sur MP] (aménagement d'intérieur pour dessiner le plan d'une maison, placement des meubles...)"
    echo "[14] LibreCAD (anciennement CADubuntu, DAO 2D pour modéliser des dessins techniques)"
    echo "[15] Shutter [Pour Xorg uniquement!] (pour effectuer des captures d'écran + appliquer des modifications diverses)"
    echo "[16] Frogr (Utile pour ceux qui utilisent le service web 'Flickr')"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 2 4) : " choixGraphisme
    clear

    # Question 9 : Traitement/encodage audio
    echo "*******************************************************"
    echo "9/ Quel(s) logiciels(s) pour l'encodage/réglage ou traitement audio ?"
    echo "*******************************************************"
    echo "[1] Aucun"
    echo "[2] SoundConverter (petit logiciel pour convertir des lots de fichiers audios)"
    echo "[3] Xcfa : X Convert File Audio (extraction cd audio, piste dvd, normalisation, création pochette)"
    echo "[4] Sound-Juicer (pour extraire les pistes audios d'un cd)"
    echo "[5] SoundKonverter (convertisseur audio utilisant les bilbiothèques Qt)"
    echo "[6] Gnome Sound Recorder (pour enregistrer et lire du son, realisé par défaut avec OggVorbis)"
    echo "[7] Audacity (enregistrement et édition de son numérique)"
    echo "[8] MhWaveEdit (application libre d'enregistrement et d'édition audio complète distribuée sous GPL)"
    echo "[9] Flacon (pour extraire les pistes d'un gros fichier audio pour sauvegarder en différents fichiers distincts)"
    echo "[10] RipperX (une autre alternative pour extraire les cd de musique)"
    echo "[11] Grip (Ripper facilement des cd de musique)"
    echo "[12] LMMS : Let's Make Music (station audio opensource crée par des musiciens pour les musiciens)"
    echo "[13] MiXX (logiciel pour Dj pour le mixage de musique)"
    echo "[14] Ardour (station de travail audio numérique avec enregistrement multipiste et mixage : logiciel lourd !)"
    echo "[15] Rosegarden (création musicale avec édition des partitions et peux s'interfacer avec des instruments)"
    echo "[16] Pavucontrol (outil graphique de contrôle des volumes audio entrée/sortie pour Pulseaudio)"
    echo "[17] Lame (outil d'encodage en CLI pour le format MP3,par ex pour convertir un Wav en Mp3)"
    echo "[18] PulseEffects [Flatpak] (interface puissante GTK pour faire pleins de réglage/effet sur le son)"

    read -p "Répondre par le ou les chiffres correspondants (exemple : 2 4) : " choixAudio
    clear

    # Question 10 : Bureautique et Mail
    echo "*******************************************************"
    echo "10/ Quel(s) logiciel(s) de bureautique/courrier souhaitez-vous ?"
    echo "*******************************************************"
    echo "[1] Aucun supplément (par défaut : Evince pour pdf, LibreOffice en bureautique, Thunderbird pour les mails)"
    echo "[2] Supplément LibreOffice : ajout du module 'Base' + des extensions utiles (templates, modèles de documents, clipboard...)"
    echo "[3] a_modifier..."
    echo "[4] Marp (Permet de créer une présentation rapide en s’affranchissant des outils bureautiques lourds)"
    echo "[5] PdfMod (logiciel permettant diverses modifications sur vos PDF)"
    echo "[6] (scenarichaine + opale : famille d'applications d'édition avancées de chaînes éditoriales)"
    echo "[7] Freeplane (création de cartes heuristiques (Mind Map) avec des diagrammes représentant les connexions sémantiques)"
    echo "[8] FeedReader [Flatpak] (agrégateur RSS moderne pour consulter vos fils d'informations RSS)"
    echo "[9] Geary (logiciel de messagerie, alternative à Thunderbird et bien intégré à Gnome)"
    echo "[10] Gnome Evolution (logiciel de type groupware et courrielleur, facile à utiliser)"
    echo "[11] WPSOffice (Clone de Microsoft Office, propriétaire aussi)"
    echo "[12] OnlyOffice (bureautique avec des outils de collaboration et gestion de documents)"
    echo "[13] Gnome Office (pack contenant Abiword, Gnumeric, Dia, Planner, Glabels, Glom, Tomboy et Gnucash)"
    echo "[14] Apache OpenOffice (Déconseillé ! préviligiez LibreOffice qui est installé par défaut)"
    echo "[15] OOo4Kids (Suite bureautique spécialement simplifié pour les enfants)"
    echo "[16] Wordgrinder (Traitement de texte léger. Formats OpenDocument, HTML import and export)"
    echo "[17] LaTex (langage de description de document très utile pour les documents formatés de manière logique)"
    echo "[18] MailSpring [Snap] (client de messagerie moderne et multi-plateforme)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 1) : " choixBureautique
    clear

    # Question 11 : Science et éducation (voir pour Scratch2 + Celestia ?)
    echo "*******************************************************"
    echo "11/ Des logiciels de science ou pour l'éducation ?"
    echo "*******************************************************"
    echo "[1] Pas d'ajout"
    echo "[2] Google Earth (globe terrestre de Google pour explorer la planète)"
    echo "[3] [GEO] Extension OooHg pour LibreOffice (ajoute 1600 cartes de géographie)"
    echo "[4] [SCIENCE] SciLab (Logiciel scientifique pour le calcul numérique pour des applications scientifiques"
    echo "[5] [MATH] GeoGebra (géométrie dynamique pour manipuler des objets avec un ensemble de fonctions algébriques)"
    echo "[6] [MATH] Algobox (Logiciel libre d'aide à l'élaboration/exécution d'algorithmes en mathématique)"
    echo "[7] [MATH] CaRMetal (Logiciel libre de géométrie dynamique, créé à partir du moteur de C.a.R.)"
    echo "[8] [ASTRO] Stellarium (Planétarium avec l'affichage du ciel réaliste en 3D avec simulation d'un téléscope)"
    echo "[9] [ASTRO] SkyChart (Cartographie céleste très complet avec un catalogue riche)"
    echo "[10] [CHIMIE] Avogadro (Éditeur/visualiseur avancé de molécules pour le calcul scientifique en chimie)"
    echo "[11] [TECHNO] Scratch (langage de prog visuel libre et OpenSource, créé par le MIT, à vocation éducative et ludique)"
    echo "[12] [TECHNO] mBlock (environnement de programmation par blocs basé sur Scratch 2, permet le pilotage d'Arduino"
    echo "[13] [TECHNO] Phratch (fork de Scratch, 100% libre, sans besoin de Flash ni d'Adobe Air)"
    echo "[14] [TECHNO] Récupérer Algoid [.jar] (Language de programmation éducatif)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 1) : " choixScience
    clear

    # Question 12 : Utilitaires 
    echo "*******************************************************"
    echo "12/ Quel(s) utilitaire(s) supplémentaire(s) voulez-vous ?"
    echo "*******************************************************"
    echo "[1] Aucun"
    echo "[2] Kazam (capture vidéo de votre bureau)"
    echo "[3] SimpleScreenRecorder (autre alternative pour la capture vidéo)"
    echo "[4] OpenBroadcaster Software (Pour faire du live en streaming, adapté pour les gameurs)"
    echo "[5] Glances (afficher l'état des ressources systèmes en temps réel, comme htop mais plus complet)"
    echo "[6] Brasero (logiciel de gravure de cd/dvd)" 
    echo "[7] Wine (une sorte d'émulateur pour faire tourner des applis/jeux conçu à la base pour Windows)"
    echo "[8] Ajouter Oracle Java (propriétaire)"
    echo "[9] Installer FlashPlayer (via le dépot partenaire)"
    echo "[10] VirtualBox (virtualisation de système)"
    echo "[11] VMWare Workstation Player (version gratuite de VmWare Workstation mais pas libre)"
    echo "[12] Bleachbit [potentiellement dangereux !] (efface les fichiers inutiles/temporaires du système)"
    echo "[13] KeePassX 2 (centralise la gestion de vos mots de passe personnels protégé par un master password)"
    echo "[14] TeamViewer (logiciel propriétaire de télémaintenance disposant de fonctions de bureau à distance)"
    echo "[15] Cheese (outil pour prendre des photos/vidéos à partir d'une webcam)"
    echo "[16] CoreBird [Flatpak] (Un client de bureau pour le réseau social Twitter)"
    echo "[17] Gnome Recipes (pour les gourmets : appli Gnome spécialisé dans les recettes de cuisine)"
    echo "[18] Gufw (interface graphique pour le pare-feu installé par défaut dans Ubuntu 'Ufw')"
    echo "[19] Gnome Enfs Manager (coffre-fort pour vos fichiers/dossiers)"
    echo "[20] Pack d'appli en cyber-sécurité (aircrack-ng + John The Ripper[snap] + Wireshark + Nmap)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 1) : " choixUtilitaire
    clear

    # Question 13 : Gaming
    echo "*******************************************************"
    echo "13/ Quel(s) jeux-vidéos (ou applis liés aux jeux) installer ?"
    echo "*******************************************************"
    echo "[1] Aucun, je ne suis pas un gameur"
    echo "[2] Steam (plateforme de distribution de jeux. Permet notamment d'installer Dota2, TF2, CS, TR...)"
    echo "[3] PlayOnLinux (permet de faire tourner des jeux Windows via Wine avec des réglages pré-établis)"
    echo "[4] Minecraft (un des plus célèbres jeux sandbox, jeu propriétaire et payant)"
    echo "[5] Minetest (un clone de Minecraft mais libre/opensource et totalement gratuit)"
    echo "[6] OpenArena (un clone libre du célèbre jeu 'Quake')"
    echo "[7] 0ad: Empires Ascendant (jeu de stratégie en temps réel RTS)"
    echo "[8] FlightGear (simulateur de vol)"
    echo "[9] SuperTux (clone de Super Mario mais avec un pingouin)"
    echo "[10] SuperTuxKart (clone de Super Mario Kart)"
    echo "[11] Assault Cube (clone de Counter Strike)"
    echo "[12] World Of Padman (jeu de tir basé sur Quake 3 avec des graphismes amusant)"
    echo "[13] Second Life (métavers 3D sortie en 2003 sur le modèle f2p)"
    echo "[14] Gnome Games (Pack d'une dizaine de mini-jeux pour Gnome)"
    echo "[15] Albion Online [Flatpak] (MMORPG avec système de quête et donjons)"
    echo "[16] Megaglest (RTS 3d dans un monde fantastique avec 2 factions qui s'affrontent : la magie et la technologie)"
    echo "[17] Pingus (Clone de Lemmings, vous devrez aider des manchots un peu idiots à traverser des obstacles)"
    echo "[18] Battle for Wesnoth [Flatpak] (stratégie, le joueur doit se battre pour retrouver sa place dans le royaume)"
    echo "[19] RunScape [Flatpak] (Reconnu MMORPG gratuit le plus populaire au monde avec plus de 15 Millions de comptes F2P)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3) : " choixGaming
    clear
fi

## Mode avancé (seulement pour mode avancé et extra)
if [ "$choixMode" = "2" ] || [ "$choixMode" = "3" ]
then
    # Question 14 : Extension 
    echo "*******************************************************"
    echo "14/ Des extensions pour navigateur ou gnome-shell à installer ? [mode avancé]"
    echo "*******************************************************"
    echo "[1] Non, ne pas ajouter de nouvelles extensions"
    echo "[2] Chrome Gnome Shell (extension pour navigateur : permet d'installer une extension Gnome depuis le site web)"
    echo "[3] AlternateTab (alternative au Alt+Tab issu du mode classique)"
    echo "[4] Caffeine (permet en 1 clic de désactiver temporairement les mises en veilles)"
    echo "[5] DashToDock (permet + d'option pour les réglages du dock, celui d'Ubuntu étant basé dessus)"
    echo "[6] DashToPanel (un dock alternatif conçu pour remplacer le panel de Gnome, se place en bas ou en haut)"
    echo "[7] Clipboard Indicator (permet de conserver du contenu copier/coller facilement accessible depuis le panel)"
    echo "[8] Hide Top Bar (permet de cacher le panel en haut avec nombreux réglages possibles)"
    echo "[9] Impatience (permet d'augmenter la vitesse d'affichage des animations de Gnome Shell)"
    echo "[10] Log Out Button (ajouter un bouton de déconnexion pour gagner 1 clic en moins pour cette action)"
    echo "[11] Media Player Indicator (ajouter un indicateur pour le contrôle du lecteur multimédia)"
    echo "[12] Multi monitors add on (ajoute au panel un icone pour gérer rapidement les écrans)"
    echo "[13] Weather (Pour avoir la météo directement sur votre bureau)"
    echo "[14] Places status indicator (Permet d'ajouter un raccourci vers les dossiers utiles dans le panel)"
    echo "[15] Removable drive menu (Raccourci pour démonter rapidement les clés usb/support externe)"
    echo "[16] Shortcuts (Permet d'afficher un popup avec la liste des raccourcis possibles)"
    echo "[17] Suspend button (Ajout d'un bouton pour activer l'hibernation)"
    echo "[18] Taskbar (Permet d'ajouter des raccourcis d'applis directement sur le panel en haut)"
    echo "[19] Trash (Ajoute un raccourci vers la corbeille dans le panel en haut)"
    echo "[20] User themes (Pour charger des thèmes pour Gnome Shell à partir du répertoire de l'utilisateur)"
    echo "[21] Window list (Affiche la liste des fênêtres en bas du bureau, comme à l'époque sous Gnome 2)"
    echo "[22] Workspace indicator (Affiche dans le panel en haut dans quel espace de travail vous êtes)"
    echo "[23] System-monitor (Moniteur de ressource visible directement depuis le bureau)"
    echo "[24] Top Icons Plus (Permet d'afficher un icone de notification pour les applis en haut à droite)"
    echo "[25] Unite (Retire la décoration des fenêtres pour gagner de l'espace, pour un style proche du shell Unity)"
    echo "[26] AppFolders Management (Permet de classer les applis dans des dossiers)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 1) : " choixExtension
    clear

    # Question 15 : Customization
    echo "*******************************************************"
    echo "15/ Sélectionnez ce qui vous intéresses en terme de customization [mode avancé]"
    echo "*******************************************************"
    echo "[1] Pas d'ajout"
    echo "[2] Pack de thème GTK à succès : Arc + Numix + United Gnome Darker + Gnome OS X + Silicon"
    echo "[3] Pack2 avec encore d'autres thèmes : Adapta + Minwaita Vanilla + Plano + Greybird/Blackbird/Bluebird + PopGTK"
    echo "[4] Pack3 de thème : albatross, Yuyo, human, gilouche"
    echo "[5] Remettre le thème gris pour GDM (par défaut violet) : Attention ! ajoute la session Vanilla en dépendance !"
    echo "[6] Pack d'icone 1 : Numix, Breathe, Breeze, Elementary, Brave + supplément extra icone Gnome"
    echo "[7] Pack d'icone 2 : Dust, Humility, Garton, Gperfection2, Nuovo"
    echo "[8] Pack d'icone 3 : Human, Moblin, Oxygen, Fuenza, Suede, Yasis"
    echo "[9] Pack de curseur : Breeze + Moblin + Oxygen/Oxygen-extra"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 2 5) : " choixCustom
    clear

    # Question 16 : Prog
    echo "*******************************************************"
    echo "16/ Quel éditeur de texte ou logiciel de Dev (IDE) voulez-vous ? [mode avancé]"
    echo "*******************************************************"
    echo "[1] Aucun (en dehors de Vim et Gedit)"
    echo "[2] Gvim (interface graphique pour Vim)"
    echo "[3] Emacs (le couteau suisse des éditeurs de texte, il fait tout mais il est complexe)"
    echo "[4] Geany (EDI rapide et simple utilisant GTK2 supportant de nombreux languages)"
    echo "[5] PyCharm [Snap] (IDE spécialisé pour le language Python)"
    echo "[6] Visual Studio Code [Snap] (Développé par Microsoft, sous licence libre MIT)"
    echo "[7] Atom [Snap] (Éditeur sous licence libre qui supporte les plug-ins Node.js et implémente GitControl)"
    echo "[8] Brackets [Snap] (Éditeur opensource d'Adobe pour le web design et dev web HTML, CSS, JavaScript...)"
    echo "[9] Sublime Text (Logiciel développé en C++ et Python prenant en charge 44 languages de prog)"
    echo "[10] Code:Blocks (IDE spécialisé pour le language C/C++)"
    echo "[11] IntelliJ Idea [Snap] (IDE Java commercial de JetBrains, plutôt conçu pour Java)"
    echo "[12] JEdit (Éditeur libre, multiplateforme et très personnalisable)"
    echo "[13] Eclipse (Projet décliné en sous-projets de développement, extensible, universel et polyvalent)"
    echo "[14] Anjuta (IDE simple pour C/C++, Java, JavaScript, Python et Vala)"
    echo "[15] Kdevelop (IDE gérant de nombreux language conçu plutôt pour KDE)"
    echo "[16] Android Studio (IDE de Google spécialisé pour le développement d'application Android)"
    echo "[17] Netbeans (EDI supportant plusieurs langage, surtout Java, avec de nombreux plugins)"
    echo "[18] BlueFish (éditeur orienté développement web : HTML/PHP/CSS/...)"
    echo "[19] BlueGriffon (éditeur HTML/CSS avec aperçu du rendu en temps réel)"
    echo "[20] SciTE : Scintilla Text Editor (éditeur web avec une bonne coloration syntaxique)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 4 5) : " choixDev
    clear

    # Question 17 : Serveur 
    echo "*******************************************************"
    echo "17/ Des fonctions serveurs à activer ? [mode avancé]"
    echo "*******************************************************"
    echo "[1] Pas de service à activer"
    echo "[2] Serveur SSH (Pour contrôler votre PC à distance via SSH)"
    echo "[3] Serveur LAMP (Pour faire un serveur web avec votre PC : Apache + MariaDB + PHP)"
    echo "[4] Serveur FTP avec ProFTPd (Stockage de fichier sur votre machine via FTP)"
    echo "[5] Serveur BDD PostgreSQL (Pour installer une base de donnée PostgreSQL)"
    echo "[6] Serveur BDD Oracle (Pour créer une base Oracle sur votre machine)"
    echo "[7] Rétroportage PHP5 (Ancienne version de PHP rétroporté)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 1) : " choixServeur
    clear

    # Question 18 : Optimisation
    echo "*******************************************************"
    echo "18/ Des optimisations supplémentaires à activer ? [mode avancé]"
    echo "*******************************************************"
    echo "[1] Non"
    echo "[2] Déporter répertoire snappy dans /home pour gagner de l'espace (utile si le /home est séparé et racine limité)"
    echo "[3] Optimisation Swap : swapiness à 5% + cache_pressure à 50 (swap utilisé uniquement si + de 95% de ram utilisé)"
    echo "[4] Désactiver complètement le swap (utile si vous avez un SSD et 8 Go de ram ou +)"
    echo "[5] Activer TLP avec Powertop et Laptop-mode-tools (économie d'energie pour pc portable)"
    echo "[6] Installer le microcode propriétaire Intel (pour cpu intel uniquement !)"
    echo "[7] Ajouter une commande 'fraude' pour Wayland (pour pouvoir lancer des applis comme Gparted. Exemple : fraude gparted)"
    echo "[8] Désactiver l'userlist de GDM (utile en entreprise intégré à un domaine)"
    echo "[9] Ajouter le support pour le système de fichier exFat de Microsoft"
    echo "[10] Ajouter le support pour le système de fichier HFS d'Apple"
    echo "[11] Ajout d'une nouvelle commande magique 'maj' qui met tout à jour d'un coup (maj apt + purge + maj snap + maj flatpak)"
    echo "[12] Optimisation Grub : réduire le temps d'attente (si multiboot) de 10 à 2 secondes + retirer le test de RAM dans grub"
    echo "[13] Pouvoir lire vos DVD/BR commerciaux achetés et protégés par CSS (Content Scrambling System)"
    echo "[14] Installer + Configurer Bumblebee (pilote Nvidia proprio) pour portable avec technologie Optimus nvidia/intel"
    echo "[15] Support imprimantes HP (hplip + sane + hplip-gui)"
    read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3 7) : " choixOptimisation
    clear
fi

# Mode Extra
if [ "$choixMode" = "3" ] 
    # Question 19 : Snap
    echo "*******************************************************"
    echo "19/ Mode Extra : supplément paquet Snap : "
    echo "*******************************************************"
    echo "[1] Aucun"
    echo "[2] ..."
    read -p "Choix snappy : " choixSnap
    clear
    
    # Question 20 : Flatpak
    echo "*******************************************************"
    echo "20/ Mode Extra : supplément paquet Flatpak : "
    echo "*******************************************************"
    echo "[1] Aucun"
    echo "[2] ..."
    read -p "Choix flatpak : " choixFlatpak
    clear

    # Question 21 : Appimages
    echo "*******************************************************"
    echo "21/ Mode Extra : récupération Appimages: "
    echo "*******************************************************"
    echo "[1] Aucune"
    echo "[2] ..."
    read -p "Choix appimage : " choixAppimage
    clear
fi


### Section installation automatisé

## Les choses utiles recommandés pour tous :

# Activation du dépot partenaire 
sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

#Maj du système + nettoyage
apt update ; apt full-upgrade -y ; apt autoremove --purge -y ; apt clean

# Utile pour Gnome
apt install dconf-editor gnome-tweak-tool gedit-plugins nautilus-image-converter gnome-themes-standard gnome-weather -y

# Autres outils utiles
apt install net-tools vim htop gparted openjdk-8-jre flatpak hardinfo ppa-purge numlockx unace unrar -y

#Police d'écriture Microsoft
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | /usr/bin/debconf-set-selections | apt install ttf-mscorefonts-installer -y
           
# Suppression de l'icone Amazon
apt remove ubuntu-web-launchers -y

# Codecs utiles
apt install ubuntu-restricted-extras x264 x265 libavcodec-extra -y

# Désactivation de l'affichage des messages d'erreurs à l'écran
echo "enabled=0" > /etc/default/apport

# Pour mode novice :
if [ "$choixMode" = "0" ]
then
    #internet
    apt install chromium-browser pidgin -y
    #multimédia
    apt install vlc gnome-mpv pitivi gimp pinta -y
    #divers
    apt install brasero adobe-flashplugin
fi


## Installation suivant les choix de l'utilisateur :

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
        apt install unity-session unity-tweak-tool -y #session unity      
    fi
done

# Q3/ Installation des navigateurs demandées
for navigateur in $choixNavigateur
do
    case $navigateur in
        "2") #firefox béta 
            add-apt-repository ppa:mozillateam/firefox-next -y 
            apt update ; apt upgrade -y
            ;;
         "3") #firefox developper edition 
            flatpak install --from https://firefox-flatpak.mojefedora.cz/org.mozilla.FirefoxDevEdition.flatpakref -y
            ;;
         "4") #firefox esr
            add-apt-repository ppa:mozillateam/ppa -y 
            apt update ; apt install firefox-esr -y
            ;;
         "5") #firefox nightly
            flatpak install --from https://firefox-flatpak.mojefedora.cz/org.mozilla.FirefoxNightly.flatpakref -y
            ;;
         "6") #chromium
            apt install chromium-browser -y    
            ;;
         "7") #chrome
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
            sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
            apt update ; apt install google-chrome-stable -y
            ;;
         "8") #epiphany
            apt install epiphany-browser -y
            ;;
         "9") #midori
            wget http://midori-browser.org/downloads/midori_0.5.11-0_amd64_.deb
            dpkg -i midori_0.5.11-0_amd64_.deb
            apt install -fy
            ;;
         "10") #opera 
            wget -q http://deb.opera.com/archive.key -O- | apt-key add -
            apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 517590D9A8492E35
            echo "deb https://deb.opera.com/opera/ stable non-free" | tee -a /etc/apt/sources.list.d/opera-stable.list
            apt update ; apt install opera-stable -y
            ;;
         "11") #palemoon 
            wget http://download.opensuse.org/repositories/home:/stevenpusser/xUbuntu_17.04/amd64/palemoon_27.6.0~repack-1_amd64.deb
            dpkg -i palemoon_27.6.0~repack-1_amd64.deb
            apt install -fy 
            ;;
         "12") #vivaldi x64
            apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2CC26F777B8B44A1
            echo "deb http://repo.vivaldi.com/stable/deb/ stable main" >> /etc/apt/sources.list.d/vivaldi.list
            apt update ; apt install vivaldi-stable -y
            ;;
         "13") #Falkon/Qupzilla
            apt install qupzilla -y
         ;;
         "14") #Tor browser
            apt install torbrowser-launcher -y
         ;;
         "15") #Eolie via Flatpak
            flatpak install --from https://flathub.org/repo/appstream/org.gnome.Eolie.flatpakref -y
         ;;
         "16") Min
            wget https://github.com/minbrowser/min/releases/download/v1.6.3/Min_1.6.3_amd64.deb
            dpkg -i Min_1.6.3_amd64.deb
            apt install -fy
         ;;
         "17") #Rekonq
            apt install rekonq -y
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

# Q4/ Tchat/Messagerie instantannée/Télephonie
for messagerie in $choixMessagerie
do
    case $messagerie in
        "2") #empathy
            apt install empathy -y
            ;;
        "3") #pidgin
            apt install pidgin pidgin-plugin-pack -y
            ;;
        "4") #jitsi
            wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | apt-key add -   
            sh -c "echo 'deb https://download.jitsi.org stable/' > /etc/apt/sources.list.d/jitsi-stable.list"   
            apt update ; apt install jitsi -y   
            ;;
        "5") #psi
            apt install psi -y
            ;;         
        "6") #gajim
            apt install gajim -y
            ;;
        "7") #skype
            wget https://repo.skype.com/latest/skypeforlinux-64.deb
            dpkg -i skypeforlinux-64.deb
            apt install -fy
            ;;            
        "8") #ekiga
            apt install ekiga -y
            ;;           
        "9") #linphone
            apt install linphone -y
            ;;           
        "10") #ring
            apt install ring -y
            ;;        
        "11") #mumble
            apt install mumble -y
            ;;    
        "12") #teamspeak (vérifier le fonctionnement, demande peut être intervention pour l'install)
            wget http://dl.4players.de/ts/releases/3.1.6/TeamSpeak3-Client-linux_amd64-3.1.6.run
            chmod +x TeamSpeak3-Client-linux_amd64-3.1.6.run
            ./TeamSpeak3-Client-linux_amd64-3.1.6.run
            ;;       
        "13") #discord (via snap)
            snap install discord
            ;;                         
        "14") #tox
            apt install tox -y
            ;;               
        "15") #viber
            flatpak install --from https://flathub.org/repo/appstream/com.viber.Viber.flatpakref -y
            ;;               
        "16") #telegram (Snap)
            snap install telegram-sergiusens
            ;;              
        "17") #wire
            apt-key adv --fetch-keys http://wire-app.wire.com/linux/releases.key
            echo "deb https://wire-app.wire.com/linux/debian stable main" | tee /etc/apt/sources.list.d/wire-desktop.list
            apt update ; apt install apt-transport-https wire-desktop -y
            ;;               
        "18") #hexchat
            apt install hexchat hexchat-plugins -y
            ;; 
        "19") #signal (flatpak)
            flatpak install --from https://vrutkovs.github.io/flatpak-signal/signal.flatpakref -y
            ;;           
        "20") #Polari
            apt install polari -y
            ;;
        "21") #Slack (flatpak)
            flatpak install --from https://flathub.org/repo/appstream/com.slack.Slack.flatpakref -y
            ;;     
    esac
done

# Q5/ Download/Copie
for download in $choixTelechargement
do
    case $download in
        "2") #filezilla
            apt install filezilla -y
            ;;
        "3") #Deluge
            apt install deluge -y
            ;;
        "4") #Rtorrent
            apt install rtorrent screen -y
            ;;
        "5") #qBittorrent
            apt install qbittorrent -y
            ;;         
        "6") #Bittorrent
            apt install bittorrent bittorrent-gui -y
            ;;            
        "7") #Vuze
            snap install vuze-vs
            ;;           
        "8") #aMule
            apt install amule -y
            ;;           
        "9") #FrostWire
            wget https://netcologne.dl.sourceforge.net/project/frostwire/FrostWire%206.x/6.5.9-build-246/frostwire-6.5.9.all.deb
            dpkg -i frostwire-6.5.9.all.deb
            apt install -fy
            ;;        
        "10") #Gtk-Gnutella
            apt install gtk-gnutella -y
            ;;    
        "11") #EiskaltDC++
            apt install eiskaltdcpp eiskaltdcpp-gtk3 -y
            ;;       
        "12") #RetroShare
            add-apt-repository ppa:ppa:retroshare/stable -y
            apt update ; apt install retroshare -y
            ;;                         
        "13") #Calypso
            wget https://netcologne.dl.sourceforge.net/project/calypso/kommute/0.24/kommute_0.24-2_i386.deb
            dpkg -i kommute_0.24-2_i386.deb
            apt install -fy
            ;;               
        "14") #Grsync
            apt install grsync -y
            ;;               
        "15") #SubDownloader
            apt install subdownloader -y
            ;;              
        "16") #Nicotine+ 
            apt install nicotine -y
            ;;                   
        "17") #Gydl
            flatpak install --from https://flathub.org/repo/appstream/com.github.JannikHv.Gydl.flatpakref -y
            ;;   
    esac
done

# Q6/ Lecture multimédia
for multimedia in $choixMultimedia
do
    case $multimedia in
        "2") #VLC
            apt install vlc vlc-plugin-vlsub vlc-plugin-visualization -y
            ;;
        "3") #Gnome MPV
            apt install gnome-mpv -y
            ;;
        "4") #SmPlayer
            apt install smplayer smplayer-l10n smplayer-themes -y
            ;;
        "5") #gxine
            apt install gxine  -y
            ;;         
        "6") #dragonplayer
            apt install dragonplayer -y
            ;;
        "7") #Banshee + extensions
            apt install banshee -y
            ;;            
        "8") #Clementine
            apt install clementine -y
            ;;           
        "9") #QuodLibet
            apt install quodlibet -y
            ;;           
        "10") #audacious
            apt install audacious audacious-plugins -y
            ;;        
        "11") #Guayadeque #(dépot pour Artful utilisé car Bionic pas encore activé mais fonctionnement validé)
            echo "deb http://ppa.launchpad.net/anonbeat/guayadeque/ubuntu artful main" >> /etc/apt/sources.list.d/anonbeat-ubuntu-guayadeque-bionic.list
            apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 95FABEFB4499973B
            apt update
            apt install guayadeque -y
            ;;    
        "12") #gnome music
            apt install gnome-music -y
            ;;       
        "13") #gmusicbrowser
            apt install gmusicbrowser -y
            ;;                         
        "14") #musique
            apt install musique -y
            ;;               
        "15") #qmmp
            apt install qmmp -y
            ;;               
        "16") #xmms2 + plugins
            apt install xmms2 xmms2-plugin-all gxmms2 -y
            ;;              
        "17") #Lollypop 
            flatpak install --from https://flathub.org/repo/appstream/org.gnome.Lollypop.flatpakref -y
            ;;             
        "18") #Spotify (via flatpak)
            flatpak install --from https://flathub.org/repo/appstream/com.spotify.Client.flatpakref -y
            ;;     
        "19") #MuseScore (via flatpak)
            flatpak install --from https://flathub.org/repo/appstream/org.musescore.MuseScore.flatpakref -y
            ;;         
        "20") #Gnome Twitch
            apt install gnome-twitch -y
            ;;         
        "21") #Gradio (flatpak)
            flatpak install --from https://flathub.org/repo/appstream/de.haeckerfelix.gradio.flatpakref -y
            ;;    
        "22") #Molotov.tv (appimage)
            wget https://desktop-auto-upgrade.s3.amazonaws.com/linux/1.8.0/molotov
            mv molotov molotov.AppImage && chmod +x molotov.AppImage
            ;; 
    esac
done

# Q7/ Montage vidéo
for video in $choixVideo
do
    case $video in
        "2") #Handbrake
            apt install handbrake -y
            ;;
        "3") #WinFF
            apt install winff winff-doc winff-qt -y
            ;;
        "4") #Libav-tools
            apt install libav-tools -y
            ;;
        "5") #KDEnLive
            apt install kdenlive breeze-icon-theme -y
            ;;
        "6") #OpenShot Video Editor
            apt install openshot openshot-doc -y
            ;;
        "7") #Pitivi
            apt install pitivi -y
            ;;
        "8") #Lives
            apt install lives -y
            ;;         
        "9") #Shotcut (Snap)
            snap install shotcut --classic
            ;;            
        "10") #SlowMoVideo
            add-apt-repository ppa:ubuntuhandbook1/slowmovideo -y
            apt update ; apt install slowmovideo -y
            ;;           
        "11") #Flowblade
            apt install flowblade -y
            ;;           
        "12") #Cinelerra  #vérifier stabilité !!!
            add-apt-repository ppa:cinelerra-ppa/ppa -y
            apt update ; apt install cinelerra-cv -y
            ;;        
        "13") #Natron
            wget https://downloads.natron.fr/Linux/releases/64bit/files/natron_2.3.3_amd64.deb
            dpkg -i natron_2.3.3_amd64.deb
            apt install -fy
            ;;    
        "14") #LightWorks (a tester sur une vrai machine, KO sur VM)
            wget https://downloads.lwks.com/v14/lwks-14.0.0-amd64.deb
            dpkg -i lwks-14.0.0-amd64.deb
            apt install -fy
            ;;                             
        "15") #Avidemux (AppImage)
            wget http://nux87.free.fr/script-postinstall-ubuntu/appimage/avidemux2.7.0.AppImage
            chmod +x avidemux2.7.0.AppImage
            ;;               
        "16") #Mencoder
            apt install mencoder -y
            ;;               
        "17") #MMG MkvMergeGui
            apt install mkvtoolnix mkvtoolnix-gui -y
            ;;              
        "18") #DeVeDe 
            apt install devede -y
            ;;     
        "19") #Jahshaka 
            apt install libfuse2:i386 -y 
            wget https://netix.dl.sourceforge.net/project/portable/Jahshaka%202.0
            chmod +x Jahshaka*
            ;;             
        "20") #Peek (via Flatpak)
            flatpak install --from https://flathub.org/repo/appstream/com.uploadedlobster.peek.flatpakref -y
            ;;  
    esac
done

# Q8/ Montage photo/graphisme/3d
for graphisme in $choixGraphisme
do
    case $graphisme in
        "2") #Gimp
            apt install gimp gimp-help-fr gimp-plugin-registry gimp-ufraw gimp-data-extras -y
            ;;
        "3") #Krita
            apt install krita krita-l10n -y
            ;;
        "4") #Pinta
            apt install pinta -y
            ;;
        "5") #Pixeluvo
            wget http://www.pixeluvo.com/downloads/pixeluvo_1.6.0-2_amd64.deb
            dpkg -i pixeluvo_1.6.0-2_amd64.deb
            apt install -fy
            ;;
        "6") #Phatch
            apt install phatch phatch-cli -y
            ;;
        "7") #MyPaint
            apt install mypaint mypaint-data-extras -y
            ;;         
        "8") #Ufraw
            apt install ufraw ufraw-batch -y
            ;;            
        "9") #Inkscape
            apt install inkscape -y
            ;;                    
        "10") #Darktable
            apt install darktable -y
            ;;          
        "11") #Blender
            apt install blender -y
            ;;       
        "12") #K-3D
            apt install k3d -y
            ;;                         
        "13") #SweetHome 3D
            apt install sweethome3d -y
            ;;               
        "14") #LibreCAD
            apt install librecad -y
            ;;        
        "15") #Shutter
            apt install shutter -y
            ;;    
        "16") #Frogr
            apt install frogr -y
            ;;    
    esac
done

# Q9/ Traitement audio
for audio in $choixAudio
do
    case $audio in
        "2") #SoundConverter
            apt install soundconverter -y
            ;;
        "3") #Xcfa
            apt install xcfa -y
            ;;
        "4") #SoundJuicer
            apt install sound-juicer -y
            ;;
        "5") #SoundKonverter (risque de ne pas marcher sinon retirer)
            wget http://archive.ubuntu.com/ubuntu/pool/universe/s/soundkonverter/soundkonverter_2.2.2-1_amd64.deb
            dpkg -i soundkonverter_2.2.2-1_amd64.deb
            apt install -fy
            ;;
        "6") #Gnome Sound Recorder
            apt install gnome-sound-recorder -y
            ;;
        "7") #Audacity
            apt install audacity -y
            ;;
        "8") #MhWaveEdit
            apt install mhwaveedit -y
            ;;         
        "9") #Flacon
            add-apt-repository -y ppa:flacon/ppa
            apt update ; apt install flacon -y
            ;;
        "10") #RipperX
            apt install ripperx -y
            ;;            
        "11") #Grip
            apt install grip -y
            ;;           
        "12") #LMMS
            apt install lmms -y
            ;;           
        "13") #MiXX
            apt install mixx -y
            ;;        
        "14") #Ardour
            apt install ardour ardour-video-timeline -y
            ;;    
        "15") #Rosegarden
            apt install rosegarden -y
            ;;           
        "16") #Pavucontrol
            apt install pavucontrol -y
            ;;   
        "17") #lame
            apt install lame -y
            ;;   
        "18") #PulseEffects
            flatpak install --from https://flathub.org/repo/appstream/com.github.wwmm.pulseeffects.flatpakref -y
            ;;   
    esac
done

# Q10/ Bureautique
for bureautique in $choixBureautique
do
    case $bureautique in
        "2") #Complément LibreOffice
            apt install libreoffice libreoffice-style-oxygen libreoffice-style-human libreoffice-style-sifrm libreoffice-wiki-publisher -y
            apt install libreoffice-dmaths libreoffice-templates openclipart-libreoffice libreoffice-nlpsolver -y
            ;;
        "3") # a modifier
            #ajouté plus tard
            ;;
        "4") #Marp
            wget https://github-production-release-asset-2e65be.s3.amazonaws.com/59939691/c7ce7c0c-5769-11e7-87d0-3900a81c0345?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20171103%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20171103T104517Z&X-Amz-Expires=300&X-Amz-Signature=3208d33a5f8318058d6cd959c91c18dac13c0615f0ac2b0be2400b3be6e4ac8d&X-Amz-SignedHeaders=host&actor_id=33062503&response-content-disposition=attachment%3B%20filename%3D0.0.11-Marp-linux-x64.tar.gz&response-content-type=application%2Foctet-stream
            tar zxvf 0.0.11-Marp-linux-x64.tar.gz
            chmod +x ./0.0.11-Marp-linux-x64/Marp
            ;;
        "5") #PDFMod
            apt install pdfmod -y 
            ;;
        "6") #Scenari (dépot pas encore actif pour 18.04)
            echo "deb https://download.scenari.org/deb xenial main" > /etc/apt/sources.list.d/scenari.list
            wget -O- https://download.scenari.org/deb/scenari.asc | apt-key add -
            apt update
            apt install scenarichain4.2.fr-fr opale3.6.fr-fr -y
            ;;
        "7") #Freeplane
            apt install freeplane -y
            ;;
        "8") #Feedreader
            flatpak install --from https://flathub.org/repo/appstream/org.gnome.FeedReader.flatpakref -y
            ;;
        "9") #Geary
            apt install geary -y
            ;;        
        "10") #Gnome Evolution
            apt install evolution -y
            ;; 
        "11") #WPS Office
            wget http://kdl1.cache.wps.com/ksodl/download/linux/a21//wps-office_10.1.0.5707~a21_amd64.deb
            dpkg -i wps-office_10.1.0.5707~a21_amd64.deb
            apt install -fy
            ;; 
        "12") #OnlyOffice
            wget http://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb
            dpkg -i onlyoffice-desktopeditors_amd64.deb
            apt install -fy
            ;; 
        "13") #Gnome Office
            apt install abiword gnumeric dia planner glabels glom tomboy gnucash -y
            ;; 
        "14") #Apache OpenOffice
            wget https://freefr.dl.sourceforge.net/project/openofficeorg.mirror/4.1.4/binaries/fr/Apache_OpenOffice_4.1.4_Linux_x86_install-deb_fr.tar.gz
            tar zxvf Apache_OpenOffice_4.1.4_Linux_x86_install-deb_fr.tar.gz
            dpkg -i ./fr/DEBS/*.deb ; dpkg -i ./fr/DEBS/desktop-integration/open*.deb
            apt install -fy
            ;; 
        "15") #OOo4Kids
            wget https://downloads.sourceforge.net/project/educooo/OOo4Kids/Linux/deb/dists/testing/main/binary-amd64/ooo4kids-fr_1.3-1_amd64.deb
            dpkg -i ooo4kids-fr_1.3-1_amd64.deb
            apt install -fy
            ;;            
        "16") #Wordgrinder
            apt install wordgrinder -y
            ;;            
        "17") #Latex
            apt install texlive texlive-lang-french texlife-latex-extra -y
            ;; 
        "18") #MailSpring (Snap)
            snap install mailspring
            ;;               
    esac
done

# Q11/ Science
for science in $choixScience
do
    case $science in
        "2") #Google Earth
            wget https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb
            dpkg -i google-earth-pro-stable_current_amd64.deb
            apt install -fy
            ;;
        "3") #extension LO oooHG
            apt install ooohg -y
            ;;
        "4") #Scilab
            apt install scilab -y
            ;;
        "5") #Geogebra
            apt install geogebra -y
            ;;
        "6") #Algobox
            apt install algobox -y
            ;;
        "7") #Carmetal
            apt install carmetal -y
            ;;
        "8") #Stellarium
            apt install stellarium -y
            ;;            
        "9") #Skychart
            wget https://vorboss.dl.sourceforge.net/project/skychart/1-software/version_4.0/skychart_4.0-3575b_amd64.deb
            dpkg -i skychart_4.0-3575b_amd64.deb
            apt install -fy
            ;;
        "10") #Avogadro
            apt install avogadro -y
            ;;
        "11") #Scratch
            # A voir plus tard pour l'install...
            ;;   
        "12") #mBlock
            wget https://mblockdev.blob.core.chinacloudapi.cn/mblock-src/mBlock.deb
            dpkg -i mBlock.deb
            apt install -fy
            ;;
        "13") #Phratch (a vérifier)
            wget http://phratch.com/download/Phratch4.1-linux.zip
            unzip Phratch4.1-linux.zip
            chmod +x ./Phratch4.1-linux/phratch
            ;;  
        "14") #AlgoIDE (a vérifier)
            wget http://www.algoid.net/downloads/AlgoIDE-release.jar
            chmod +x AlgoIDE-release.jar
            ;;             
    esac
done

# Q12/ Utilitaire et divers
for utilitaire in $choixUtilitaire
do
    case $utilitaire in
        "2") #Kazam
            apt install kazam -y
            ;;
        "3") #SimpleScreenRecorder
            apt install simplescreenrecorder -y
            ;;
        "4") #OpenBroadcaster Software
            add-apt-repository ppa:obsproject/obs-studio -y
            apt update ; apt install ffmpeg obs-studio -y
            ;;
        "5") #Glances
            apt install glances -y
            ;;
        "6") #Brasero
            apt install brasero brasero-cdrkit nautilus-extension-brasero -y
            ;;
        "7") #Wine 
            apt install wine-stable -y
            ;;
        "8") #Oracle Java (d'ici la sortie, passera peut être en v9)
            add-apt-repository ppa:/webupd8team/java -y
            apt update ; apt install oracle-java8-installer -y
            ;;         
        "9") #FlashPlayer (avec dépot partenaire)
            apt install adobe-flashplugin -y
            ;;
        "10") #VirtualBox
            apt install virtualbox virtualbox-ext-pack -y
            ;;            
        "11") #VMWare Workstation Player
            wget https://download3.vmware.com/software/player/file/VMware-Player-12.5.7-5813279.x86_64.bundle?HashKey=cfce2a8b4444fd32692e9b4d2a251cf9&params=%7B%22sourcefilesize%22%3A%22128.01+MB%22%2C%22dlgcode%22%3A%22PLAYER-1257%22%2C%22languagecode%22%3A%22fr%22%2C%22source%22%3A%22DOWNLOADS%22%2C%22downloadtype%22%3A%22manual%22%2C%22eula%22%3A%22N%22%2C%22downloaduuid%22%3A%22f24b51a3-09d3-48e6-85ef-652c4ccc06e2%22%2C%22purchased%22%3A%22N%22%2C%22dlgtype%22%3A%22Product+Binaries%22%2C%22productversion%22%3A%2212.5.7%22%2C%22productfamily%22%3A%22VMware+Workstation+Player%22%7D&AuthKey=1509617319_6e970e8422684aa4c4219db17d0ab115
            chmod +x VMware-Player-12.5.7-5813279.x86_64.bundle
            ./VMware-Player-12.5.7-5813279.x86_64.bundle
            ;;  
        "12") #Bleachbit
            apt install bleachbit -y
            ;;        
        "13") #KeepassX2 (voir aussi KeePass et KeePassXC)
            apt install keepassx2 -y
            ;; 
        "14") #Teamviewer
            wget https://dl.tvcdn.de/download/version_12x/teamviewer_12.0.85001_i386.deb
            dpkg -i teamviewer_12.0.85001_i386.deb
            apt install -fy
            ;;   
        "15") #Cheese
            apt install cheese -y
            ;; 
        "16") #Corebird
            flatpak install --from https://flathub.org/repo/appstream/org.baedert.corebird.flatpakref -y
            ;;   
        "17") #Gnome Recipes
            apt install gnome-recipes -y
            ;;   
        "18") #Gufw
            apt install gufw -y
            ;;  
        "19") #Gnome Encfs Manager
            add-apt-repository ppa:gencfsm/ppa -y
            apt update ; apt install gnome-encfs-manager -y
            ;; 
        "20") #Pack cyber-sécurité
            apt install aircrack-ng wireshark nmap -y
            snap install john-the-ripper
            ;;             
    esac
done

# Q13/ Jeux
for gaming in $choixGaming
do
    case $gaming in
        "2") #Steam
            apt install steam -y
            ;;
        "3") #PlayOnLinux
            apt install playonlinux -y
            ;;
        "4") #Minecraft  (a tester si c'est ok sinon choisir autre méthode d'install)
            wget http://packages.linuxmint.com/pool/import/m/minecraft-installer/minecraft-installer_0.1+r12~ubuntu16.04.1_amd64.deb
            dpkg -i minecraft-installer_0.1+r12~ubuntu16.04.1_amd64.deb
            apt install -fy
            ;;
        "5") #Minetest + mods (à tester)
            apt install minetest minetest-mod-* -y
            ;;
        "6") #OpenArena
            apt install openarena -y
            ;;
        "7") #0ad: Empires Ascendant (ou via flatpak)
            apt install 0ad -y
            #flatpak install --from https://flathub.org/repo/appstream/com.play0ad.zeroad.flatpakref
            ;;     
        "8") #FlightGear
            apt install flightgear -y
            ;;
        "9") #SuperTux
            apt install supertux -y
            ;;            
        "10") #SuperTuxKart
            apt install supertuxkart -y
            ;;   
        "11") #Assault Cube
            apt install assaultcube -y
            ;;         
        "12") #World Of Padman
            wget https://netix.dl.sourceforge.net/project/worldofpadman/wop-1.5.x-to-1.6-patch-unified.zip
            unzip wop-1.5.x-to-1.6-patch-unified.zip
            ;;
        "13") #Second Life (a mon avis ne marchera pas, a tester)
            wget http://download.cloud.secondlife.com/Viewer_5/Second_Life_5_0_8_329115_i686.tar.bz2
            tar jxvf Second_Life_5_0_8_329115_i686.tar.bz2
            chmod +x ./Second_Life_5_0_8_329115_i686/install.sh
            ./Second_Life_5_0_8_329115_i686/install.sh
            ;;            
        "14") #Gnome Games (verifier si gg-app utile)
            apt install gnome-games gnome-games-app -y
            ;;  
        "15") #Albion online
            flatpak install --from https://flathub.org/repo/appstream/com.albiononline.AlbionOnline.flatpakref -y
            ;;
        "16") #Megaglest
            apt install megaglest -y
            ;;
        "17") #Pingus
            apt install pingus -y            
            ;;
        "18") #Battle for Wesnoth
            flatpak install --from https://flathub.org/repo/appstream/org.wesnoth.Wesnoth.flatpakref -y   
            ;;
        "19") #Runscape
            flatpak install --from https://flathub.org/repo/appstream/com.jagex.RuneScape.flatpakref -y   
            ;;
    esac
done

# Mode avancé : ne pas oublier d'ajouter plus tard une condition => Si mode avancé alors...

# 14/ Extensions (a completer plus tard)
for extension in $choixExtension
do
    case $extension in
        "2") #Chrome Gnome Shell (extension navigateur web)
            apt install chrome-gnome-shell -y
            ;;
        "3") #AlternateTab
            #a faire plus tard, cf => https://extensions.gnome.org/extension/15/alternatetab/
            ;;
        "4") #Caffeine
            apt install gnome-shell-extension-caffeine -y
            ;;
        "5") #DashToDOck
            #a faire plus tard, cf => https://extensions.gnome.org/extension/307/dash-to-dock/
            ;;
        "6") #DashToPanel
            apt install gnome-shell-extension-dash-to-panel -y
            ;;
        "7") #Clipboard Indicator
            #a faire plus tard, cf => https://extensions.gnome.org/extension/779/clipboard-indicator/
            ;;
        "8") #Hide Top bar
            #a faire plus tard, cf => https://extensions.gnome.org/extension/545/hide-top-bar/
            ;;         
        "9") #Impatience
            apt install gnome-shell-extension-impatience -y
            ;;
        "10") #Logout button
            apt install gnome-shell-extension-log-out-button -y
            ;; 
        "11") #Media Player Indicator
            apt install gnome-shell-extension-mediaplayer -y
            ;;
        "12") #Multi monitors
            apt install gnome-shell-extension-multi-monitors -y
            ;;
        "13") #Weather
            apt install gnome-shell-extension-weather -y
            ;;
        "14") #Places status indicator
            #a faire plus tard, cf => https://extensions.gnome.org/extension/8/places-status-indicator/
            ;;
        "15") #Removable drive menu
            #a faire plus tard, cf => https://extensions.gnome.org/extension/7/removable-drive-menu/
            ;;
        "16") #Shortcuts
            apt install gnome-shell-extension-shortcuts -y
            ;;
        "17") #Suspend button
            apt install gnome-shell-extension-suspend-button -y
            ;;         
        "18") #Taskbar
            apt install gnome-shell-extension-taskbar -y
            ;;
        "19") #Trash
            apt install gnome-shell-extension-trash -y
            ;;
        "20") #User themes
            #a faire plus tard, cf => https://extensions.gnome.org/extension/19/user-themes/
            ;;   
        "21") #Window list
            #a faire plus tard, cf => https://extensions.gnome.org/extension/602/window-list/
            ;;
        "22") #Workspace indicator
            #a faire plus tard, cf => https://extensions.gnome.org/extension/21/workspace-indicator/
            ;;
        "23") #System-monitor
            apt install gnome-shell-extension-system-monitor -y
            ;;         
        "24") #Top Icon Plus
            apt install gnome-shell-extension-top-icons-plus -y
            ;;
        "25") #Unite
            #a faire plus tard, cf => https://extensions.gnome.org/extension/1287/unite/
            ;;
        "26") #AppFolders Management
            #a faire plus tard, cf => https://extensions.gnome.org/extension/1217/appfolders-manager/
            ;;    
    esac
done

# Q15/ Customization
for custom in $choixCustom
do
    case $custom in
        "2") #pack theme gtk 1
            apt install arc-thene numix-blue-gtk-theme numix-gtk-theme silicon-theme -y
            #a ajouter a la suite : united gnome darker + gnomeosx
            ;;
        "3") #pack theme gtk 2
            apt-add-repository ppa:tista/adapta -y ; apt update ; apt install adapta-gtk-theme -y
            apt install blackbird-gtk-theme bluebird-gtk-theme greybird-gtk-theme -y
            #ajouter a la suite : minwaita vanilla + plano + Popgtk
            ;;
        "4") #pack theme gtk 3
            apt install albatross-gtk-theme yuyo-gtk-theme human-theme gnome-theme-gilouche -y
            ;;
        "5") #théme gris GDM (changement effectif seulement si la session vanilla est installé)
            apt install gnome-session -y # session vanilla nécessaire pour le changement du thème
            mv /usr/share/gnome-shell/theme/ubuntu.css /usr/share/gnome-shell/theme/ubuntu_old.css
            mv /usr/share/gnome-shell/theme/gnome-shell.css /usr/share/gnome-shell/theme/ubuntu.css
            ;;
        "6") #pack icone 1
            apt install numix-icon-theme breathe-icon-theme breeze-icon-theme elementary-icon-theme gnome-brave-icon-theme gnome-icon-theme-extras -y
            ;;        
        "7") #pack icone 2
            apt install gnome-dust-icon-theme gnome-humility-icon-theme gnome-icon-theme-garton gnome-icon-theme-gperfection2 gnome-icon-theme-nuovo -y
            ;;  
        "8") #pack icone 3
            apt install human-icon-theme moblin-icon-theme oxygen-icon-theme fuenza-icon-theme gnome-icon-theme-suede gnome-icon-theme-yasis -y
            ;;   
        "9") #pack curseur
            apt install breeze-cursor-theme moblin-cursor-theme oxygen-cursor-theme oxygen-cursor-theme-extra -y
            ;;      
    esac
done

# Q16/ Programmation/Dev
for dev in $choixDev
do
    case $dev in
        "2") #Gvim
            apt install vim-gtk3 -y
            ;;
        "3") #Emacs
            apt install emacs -y
            ;;
        "4") #Geany (verifier les extensions)
            apt install geany geany-plugins geany-plugin-* -y
            ;;
        "5") #PyCharm
            snap install pycharm-community
            ;;
        "6") #Visual Studio Code
            snap install vscode --classic
            ;;
        "7") #Atom
            snap install atom --classic
            ;;
        "8") #Brackets
            snap install brackets --classic
            ;;         
        "9") #Sublime Text
            wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
            apt install apt-transport-https -y
            echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
            apt update ; apt install sublime-text -y
            ;;
        "10") #Code:Blocks
            apt install codeblocks codeblocks-contrib -y
            ;;           
        "11") #IntelliJ Idea
            snap install intellij-idea-community --classic 
            ;;
        "12") #JEdit
            apt instakk jedit -y
            ;;
        "13") #Eclipse
            wget http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/oomph/epp/oxygen/R/eclipse-inst-linux64.tar.gz
            tar xvfz eclipse-inst-linux64.tar.gz
            chmod +x ./eclipse-installer/eclipse-inst
            ./eclipse-installer/eclipse-inst
            ;;
        "14") #Anjuta
            apt install anjuta anjuta-extras -y
            ;;
        "15") #develop
            #????
            ;;
        "16") #Android Studio
            add-apt-repository ppa:paolorotolo/android-studio -y
            apt update ; apt install android-studio -y
            ;;
        "17") #Netbeans
            apt install netbeans -y
            ;;         
        "18") #BlueFish
            apt install bluefish bluefish-plugins -y
            ;;
        "19") #BlueGriffon
            wget http://ftp.heanet.ie/pub/www.getdeb.net/getdeb/ubuntu/pool/apps/b/bluegriffon/bluegriffon_1.7.2-1~getdeb2~raring_amd64.deb
            dpkg -i bluegriffon_1.7.2-1~getdeb2~raring_amd64.deb
            apt install -fy
            ;;         
        "20") #SciTE
            apt install scite -y
            ;;  
    esac
done

# Q17/ Serveurs
for srv in $choixServeur
do
    case $srv in
        "2") #openssh-server
            apt install openssh-server -y
            ;;
        "3") #apache+mariadb+php
            apt install apache2 php mariadb-server libapache2-mod-php php-mysql -y
            ;;
        "4") #proftpd
            apt install proftpd gadmin-proftpd -y
            ;;
        "5") #Postgresql
            apt install postgresql -y
            ;;
        "6") #Oracle
            wget http://oss.oracle.com/el4/RPM-GPG-KEY-oracle  -O- | apt-key add -
            echo "deb http://oss.oracle.com/debian unstable main non-free" > /etc/apt/sources.list.d/oracle-db.list
            apt update ; apt install oracle-xe-universal oracle-xe-client -y
            ;;
        "7") #Retroportage PHP5
            apt install python-software-properties -y
            add-apt-repository ppa:ondrej/php -y
            apt update ; apt install php5.6 -y
            ;;
    esac
done

# Q18/ Optimisation/Réglage
for optimisation in $choixOptimisation
do
    case $optimisation in
        "2") #déportage snappy ds Home
            mv /snap /home/
            ln -s /home/snap /snap
            ;;
        "3") #Swapiness 95% +cache pressure 50
            echo vm.swappiness=5 | tee /etc/sysctl.d/99-swappiness.conf
            vm.vfs_cache_pressure=50 | tee -a /etc/sysctl.d/99-swappiness.conf
            sysctl -p /etc/sysctl.d/99-swappiness.conf
            ;;
        "4") #Désactiver swap
            swapoff /swapfile #désactive l'utilisation du fichier swap
            rm /swapfile #supprime le fichier swap qui n'est plus utile
            sed -i -e '/.swapfile*/d' /etc/fstab #ligne swap retiré de fstab
            ;;
        "5") #Activer TLP + install Powertop
            apt install tlp powertop laptop-mode-tools -y
            systemctl enable tlp
            systemctl emable tlp-sleep
            ;;
        "6") #Microcode Intel
            apt install intel-microcode -y
            ;;
        "7") #Mode fraude Wayland (proposé par Christophe C sur Ubuntu-fr.org)  #pas encore testé
            echo "#FONCTION POUR CONTOURNER WAYLAND
            fraude(){ 
                xhost + && sudo \$1 && xhost -
                }" >> /home/$SUDO_USER/.bashrc
            source /home/$SUDO_USER/.bashrc
            ;;
        "8") #Désactiver userlist GDM
            echo "user-db:user
            system-db:gdm
            file-db:/usr/share/gdm/greeter-dconf-defaults" > /etc/dconf/profile/gdm
            mkdir /etc/dconf/db/gdm.d
            echo "[org/gnome/login-screen]
            # Do not show the user list
            disable-user-list=true" > /etc/dconf/db/gdm.d/00-login-screen
            dconf update
            ;;
        "9") #Support ExFat
            apt install exfat-utils exfat-fuse -y    
            ;;
        "10") #Support HFS
            apt install hfsprogs hfsutils hfsplus -y
            ;;
        "11") #Nouvelle commande raccourci Maj totale
            echo "alias maj='sudo apt update ; sudo apt full-upgrade -y ; sudo apt autoremove --purge -y ; sudo apt clean ; sudo snap refresh ; sudo flatpak update -y'" >> /home/$SUDO_USER/.bashrc
            su $SUDO_USER ; source /home/$SUDO_USER/.bashrc ; exit
            ;;
        "12") #Grub réduction temps d'attente + suppression test ram dans grub
            sed -ri 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=2/g' /etc/default/grub
            mkdir /boot/old ; mv /boot/memtest86* /boot/old/
            update-grub
            ;;
        "13") #Lecture DVD Commerciaux (vérifier si suffisant)
            apt install libdvdcss2 -y
            ;;
        "14") #Nvidia Bumblebee pour techno optimus
            # complexe, créer un script spécialement pour ça plus tard puis le récupérer/lancer depuis ici
            ;;   
        "15") #Support imprimante HP
            apt install hplip hplip-doc hplip-gui sane sane-utils -y
            ;;   
    esac
done

# Question 19 : Extra Snap
for snap in $choixSnap
do
    case $snap in
        "2") #VLC version snap
            snap install vlc
            ;;
    esac
done        
    
# Question 20 : Extra Flatpak
for flatpak in $choixFlatpak
do
    case $flatpak in
        "2") #0ad version flatpak
            flatpak install --from https://flathub.org/repo/appstream/com.play0ad.zeroad.flatpakref -y
            ;;
        "3") #Audacity version flatpak
            flatpak install --from https://flathub.org/repo/appstream/org.audacityteam.Audacity.flatpakref -y
            ;;
        "4") #Battle Tanks
            flatpak install --from https://flathub.org/repo/appstream/net.sourceforge.btanks.flatpakref -y
            ;;            
        "5") #Blender version flatpak
            flatpak install --from https://flathub.org/repo/appstream/org.blender.Blender.flatpakref -y
            ;;             
        "6") #Dolphin Emulator
            flatpak install --from https://flathub.org/repo/appstream/org.DolphinEmu.dolphin-emu.flatpakref -y
            ;;  
        "7") #Dolphin Emulator
            flatpak install --from https://flathub.org/repo/appstream/org.DolphinEmu.dolphin-emu.flatpakref -y
            ;;              
        "8") #Extreme Tuxracer
            flatpak install --from https://flathub.org/repo/appstream/net.sourceforge.ExtremeTuxRacer.flatpakref -y
            ;;                
        "9") #Frozen Bubble
            flatpak install --from https://flathub.org/repo/appstream/org.frozen_bubble.frozen-bubble.flatpakref -y
            ;;                    
        "10") #Gnome MPV version flatpak
            flatpak install --from https://flathub.org/repo/appstream/io.github.GnomeMpv.flatpakref -y
            ;;               
        "11") #GIMP version flatpak
            flatpak install --from https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref -y
            ;;                    
        "12") #Google Play Music Desktop Player
            flatpak install --from https://flathub.org/repo/appstream/com.googleplaymusicdesktopplayer.GPMDP.flatpakref -y
            ;;              
        "13") #Homebank
            flatpak install --from https://flathub.org/repo/appstream/fr.free.Homebank.flatpakref -y
            ;;               
        "14") #LibreOffice version flatpak
            flatpak install --from https://flathub.org/repo/appstream/org.libreoffice.LibreOffice.flatpakref -y
            ;;         
        "15") #Minetest version flatpak
            flatpak install --from https://flathub.org/repo/appstream/net.minetest.Minetest.flatpakref -y
            ;;             
        "16") #Nextcloud
            flatpak install --from https://flathub.org/repo/appstream/org.nextcloud.Nextcloud.flatpakref -y
            ;;        
        "17") #Othman Quran Browser
            flatpak install --from https://flathub.org/repo/appstream/com.github.ojubaorg.Othman.flatpakref -y
            ;;  
        "18") #Password Calculator
            flatpak install --from https://flathub.org/repo/appstream/com.bixense.PasswordCalculator.flatpakref -y
            ;;             
        "19") #PPSSPP
            flatpak install --from https://flathub.org/repo/appstream/org.ppsspp.PPSSPP.flatpakref -y
            ;;              
        "20") #Riot
            flatpak install --from https://flathub.org/repo/appstream/im.riot.Riot.flatpakref -y
            ;;                
        "21") #Riot
            flatpak install --from https://flathub.org/repo/appstream/im.riot.Riot.flatpakref -y
            ;;                
        "22") #Teeworlds
            flatpak install --from https://flathub.org/repo/appstream/com.teeworlds.Teeworlds.flatpakref -y
            ;;       
        "23") #VLC version flatpak
            flatpak install --from https://flathub.org/repo/appstream/org.videolan.VLC.flatpakref -y
            ;;
    esac
done

# Question 21 : Extra Appimages
for appimage in $choixAppimage
do
    case $appimage in
        "2") #Digikam
            wget https://download.kde.org/stable/digikam/digikam-5.5.0-01-x86-64.appimage
            ;;
        "3") #Freecad
            wget https://github.com/FreeCAD/FreeCAD/releases/download/0.16.6712/FreeCAD-0.16.6712.glibc2.17-x86_64.AppImage
            ;;
        "3") #KeePassXC
            wget hhttps://github.com/keepassxreboot/keepassxc/releases/download/2.2.2/KeePassXC-2.2.2-2-x86_64.AppImage
            ;;
    esac
done
    
   
# Suppression des deb téléchargés par le script (plus nécessaire) et rangement des AppImages (a vérifier)
chown -R $SUDO_USER:$SUDO_USER *.AppImage
mkdir ./appimages ; rm *.deb ; mv *.AppImage ./appimages/

# Nettoyage/Purge
apt install -fy ; apt autoremove --purge -y ; apt clean ; clear

echo "Pour prendre en compte tous les changements, il faut maintenant redémarrer !"
read -p "Voulez-vous redémarrer immédiatement ? [o/n] " reboot
if [ "$reboot" = "o" ] || [ "$reboot" = "O" ]
then
    reboot
fi
