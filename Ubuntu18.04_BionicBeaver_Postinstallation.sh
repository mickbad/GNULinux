#!/bin/bash
# version 0.0.19 (alpha)

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
echo "[1] Mode standard (choix par défaut, recommandé pour la plupart des utilisateurs)"
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
echo "[1] Pas de navigateur supplémentaire : rester sur la version classique de Firefox (stable)"
echo "[2] Firefox Béta (n+1 cad 1 version d'avance : attention remplace la version stable !)"
echo "[3] Firefox Developper Edition (n+2 avec outil dev : attention remplace la version stable !)"
echo "[4] Firefox ESR (pour les entreprises/organisations : fonctionne indépendamment de la version stable)" #===> pas encore de ppa pour la 18.04
echo "[5] Firefox Nightly (Attention instable ! mais fonctionne indépendamment de la version stable)" #===> vérifier pertincence...
echo "[6] Chromium (la version libre/opensource de Chrome)"
echo "[7] Google Chrome (le célèbre navigateur de Google mais il est propriétaire !)"
echo "[8] Gnome Web/Epiphany (navigateur de la fondation Gnome s'intégrant bien avec cet environnement)"
echo "[9] Midori (libre & léger, utilisé notamment par défaut sur la distribution 'Elementary OS')"
echo "[10] Opera (un navigateur propriétaire relativement connu)"
echo "[11] PaleMoon (un navigateur plutôt récent, libre & performant)"
echo "[12] Vivaldi (un navigateur propriétaire avec une interface sobre assez particulière)"
echo "[13] Falkon/QupZilla (une alternative libre et légère utilisant Webkit)"
echo "[14] Tor Browser (pour naviguer dans l'anonymat avec le réseau tor : basé sur Firefox ESR)"
echo "[15] Eolie (une autre alternative pour Gnome : l'installation se fera via FlatPak)"
echo "[16] Min (un navigateur minimaliste et donc très léger)"
echo "[17] Rekonq (Attention déconseillé sous Gnome : beaucoup de dépendance KDE !!!)" 
echo "[18] NetSurf (basique mais très léger et performant)"
echo "[19] Dillo (navigateur capable de tourner sur des ordinosaures)"
echo "[20] Lynx (navigateur 100% en ligne de commande, pratique depuis une console SSH)"
echo "*******************************************************"
read -p "Répondre par le ou les chiffres correspondants séparés d'un espace (exemple : 6 11 20) : " choixNavigateur
clear

# Question 4 : Messagerie instantannée
echo "*******************************************************"
echo "4/ Quel(s) logiciels(s) de messagerie instantannée/tchat/VoIP/visio souhaites-tu ?"
echo "*******************************************************"
echo "[1] Pas de supplément (rien d'installé par défaut !)"
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
echo "[12] TeamSpeak (une autre alternative à Mumble mais propriétaire, beaucoup utilisé aussi par les joueurs)"
echo "[13] Discord (logiciel propriétaire multiplateforme pour communiquer à plusieurs pour les gameurs)"
echo "[14] Tox (une alternative opensource à Skype et sécurisé : P2P Chiffré sans serveur)"
echo "[15] Viber (logiciel de communication, surtout connue en application mobile)"
echo "[16] Telegram (appli de messagerie basée sur le cloud avec du chiffrage)"
echo "[17] Wire (un autre client de messagerie instantanée chiffré crée par Wire Swiss)"
echo "[18] Hexchat (client IRC, fork de xchat)"
read -p "Répondre par le ou les chiffres correspondants (exemple : 3 7 13 17) : " choixMessagerie
clear

# Question 5 : Download/Upload
echo "*******************************************************"
echo "5/ Quel(s) logiciels(s) de téléchargement/copie souhaites-tu ?"
echo "*******************************************************"
echo "[1] Pas de supplément ('Transmission' installé de base)"
echo "[2] FileZilla (logiciel très répendu utilisé pour les transferts FTP ou SFTP)"
echo "[3] Deluge (client BitTorrent basé sur Python et GTK+)"
echo "[4] Rtorrent (client BitTorrent en ligne de commande donc très léger)"
echo "[5] qBittorrent (client BitTorrent léger développé en C++ avec Qt4)"
echo "[6] µTorrent (client BitTorrent propriétaire assez connu sous Windows)"
echo "[7] Bittorrent (client non-libre de base pour gérer les téléchargements Torrent)"
echo "[8] Vuze alias Azureus (Plate-forme commerciale d'Azureus avec le protocole BitTorrent)"
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
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3 4 15) : " choixTelechargement
clear

# Question 6 : Lecture multimédia
echo "*******************************************************"
echo "6/ Quel(s) logiciels(s) de lecture audio/vidéo veux-tu ? (plusieurs choix possible)"
echo "*******************************************************"
echo "[1] Aucun, rester avec les choix par défaut ('Totem' pour la vidéo, 'Rhythmbox' pour la musique)"
echo "[2] VLC VideoLan (le couteau suisse de la vidéo, très complet !)"
echo "[3] MPV (léger et puissant, capable de lire de nombreux formats)"
echo "[4] SmPlayer (lecteur basé sur mplayer avec une interface utilisant Qt)"
echo "[5] Gxine (logiciel minimaliste écrit en GTK+ basé sur le moteur Xine"
echo "[6] DragonPlayer (lecteur vidéo plutôt conçu pour l'environnement KDE)" #===> vérifier si il y a un intéret sous Gnome...
echo "[7] Banshee (lecteur audio assez complet équivalent à Rhythmbox)"
echo "[8] Clementine (lecteur audio avec gestion des pochettes, genres musicaux...)"
echo "[9] QuodLibet (un lecteur audio très puissant avec liste de lecture basé sur les expressions rationnelles)"
echo "[10] Audacious (lecteur complet pour les audiophiles avec beaucoup de plugins)"
echo "[11] Guayadeque (lecteur audio et radio avec une interface agréable)"
echo "[12] Gnome Music (utilitaire de la fondation Gnome pour la gestion audio, assez basique)"
echo "[13] Gmusicbrowser (lecteur avec une interface très configurable)"
echo "[14] Musique (un lecteur épuré)"
echo "[15] Qmmp (dans le même style de Winamp pour les fans)"
echo "[16] XMMS2 (un autre lecteur audio dans le style de Winamp, très complet)"
echo "[17] Lollypop (lecture de musique adapté à Gnome avec des fonctions très avancées)"
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3) : " choixMultimedia
clear

# Question 7 : Traitement/montage video
echo "*******************************************************"
echo "7/ Souhaites-tu un logiciel de montage/encodage vidéo ?"
echo "*******************************************************"
echo "[1] Non merci (aucun n'est installé par défaut)"
echo "[2] Handbrake (transcodage de n'importe quel fichier vidéo)"
echo "[3] WinFF (encodage vidéo rapide dans différents formats)"
echo "[4] Libav-tools (fork de FFmpeg, outil en CLI pour la conversion via : avconv)"
echo "[5] KDEnLive (éditeur vidéo non-linéaire pour monter sons et images avec effets spéciaux)"
echo "[6] OpenShot Video Editor (une autre alternative comme éditeur vidéo, libre et écrit en Python)"
echo "[7] Pitivi (logiciel de montage basique avec une interface simple et intuitive)" 
echo "[8] Lives (Dispose des fonctionnalités d'éditions vidéo/son classique, des filtres et multipiste"
echo "[9] EKD (Opérations de post-prod sur les vidéos et images avec traitement par lot)"
echo "[10] Shotcut (editeur et montage vidéo libre et multi-plateformes)"
echo "[11] SlowMoVideo (Création de vidéos en slow-motion en opensource)"
echo "[12] Flowblade (Logiciel de montage video multi-piste performant)"
echo "[13] Cinelerra (montage non-linéaire sophistiqué, équivalent à Adobe première, Final Cut et Sony Vegas"
echo "[14] Natron (programme de post-prod destiné au compositing et aux effets spéciaux)"
echo "[15] LightWorks (Montage vidéo professionnel propriétaire)"
echo "[16] VLMC (montage vidéo de VideoLan, experimental !)" #===> vérifier stablilité...
echo "[17] Avidemux (c'est un peu l'équivalent de 'VirtualDub' sous Windows : coupe, filtre et ré-encodage)"
echo "[18] Mencoder (encodage de fichier vidéo, compatible avec de très nombreux formats)"
echo "[19] MMG : MkvMergeGui (interface graphique pour l'outil mkmerge : création/manipulation fichier mkv)"
echo "[20] DeVeDe (Création de DVD/CD vidéos lisibles par des lecteurs de salon)"
echo "[21] Jahshaka (Montage vidéo mais aussi effets spéciaux, post-prod en temps réel. Modulaire)"
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
echo "[7] Cinepaint (outil de retouche d'image vidéo basé sur Gimp)"
echo "[8] MyPaint (logiciel de peinture numérique développé en Python)"
echo "[9] ImageMagick (ensemble d'utilitaire en CLI pour créer/convertir des images)"
echo "[10] Ufraw (logiciel de dérawtisation capable de lire/interpréter la plupart des formats RAW)"
echo "[11] Inkscape (Logiciel spécialisé dans le dessin vectoriel, équivalent de 'Adobe Illustrator')"
echo "[12] sK1 (une autre alternative pour le dessin vectoriel comme Illustrator ou Inkscape)"
echo "[13] Darktable (gestionnaire de photos libre sous forme de table lumineuse et chambre noir)"
echo "[14] Art Of Illusion (modélisation 3D, animation et rendu)"
echo "[15] Blender (suite libre de modélisation 3d, matériaux et textures, d'éclairage, d'animation...)"
echo "[16] K-3D (Animation et modélisation polygonale et modélisation par courbes)"
echo "[17] SweetHome 3D (aménagement d'intérieur pour dessiner le plan d'une maison, placement des meubles...)"
echo "[18] LibreCAD (anciennement CADubuntu, DAO 2D pour modéliser des dessins techniques)"
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 4) : " choixGraphisme
clear

# Question 9 : Traitement/encodage audio
echo "*******************************************************"
echo "9/ Quel(s) logiciels(s) pour l'encodage ou traitement audio ?"
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
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 4) : " choixAudio
clear


# Question 10 : Utilitaires #(a compléter)
echo "*******************************************************"
echo "10/ Quel(s) utilitaire(s) supplémentaire(s) veux-tu ?"
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
read -p "Répondre par le ou les chiffres correspondants (exemple : 1) : " choixUtilitaire
clear

# Question 11 : Gaming
echo "*******************************************************"
echo "11/ Quel(s) jeux-vidéos (ou applis liés aux jeux) installer ?"
echo "*******************************************************"
echo "[1] Aucun, je ne suis pas un gameur"
echo "[2] Steam (plateforme de distribution de jeux. Permet notamment d'installer Dota2, TF2, CS, TR...)"
echo "[3] PlayOnLinux (permet de faire tourner des jeux Windows via Wine avec des réglages pré-établis)"
echo "[4] Minecraft (un des plus célèbres jeux sandbox, jeu propriétaire et payant)"
echo "[5] Minetest (un clone de Minecraft mais libre/opensource et totalement gratuit)"
echo "[6] OpenArena (un clone libre du célèbre jeu 'Quake')"
echo "[7] 0ad: Empires Ascendant (jeu de stratégie en temps réel RTS)"
echo "[8] Ryzom (MMORPG sous licence AGPL)"
echo "[9] FlightGear (simulateur de vol)"
echo "[10] SuperTux (clone de Super Mario mais avec un pingouin)"
echo "[11] SuperTuxKart (clone de Super Mario Kart)"
echo "[12] Assault Cube (clone de Counter Strike)"
echo "[13] World Of Padman (jeu de tir basé sur Quake 3 avec des graphismes amusant)"
echo "[14] Second Life (métavers 3D sortie en 2003 sur le modèle f2p)"
echo "[15] Gnome Games (Pack d'une dizaine de mini-jeux pour Gnome)"
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3) : " choixGaming
clear


## Mode avancé

# Question A12 : Extension  {a modifier.......}
echo "*******************************************************"
echo "A12/ Des extensions Gnome-Shell supplémentaires à installer ?"
echo "*******************************************************"
echo "[1] Non, ne pas ajouter de nouvelles extensions"
echo "[2] AlternateTab (alternative au Alt+Tab issu du mode classique)"
echo "[4] Caffeine (permet en 1 clic de désactiver temporairement les mises en veilles)"
echo "[5] DashToDock (permet + d'option pour les réglages du dock, celui d'Ubuntu étant basé dessus)"
echo "[6] DashToPanel (un dock alternatif conçu pour remplacer le panel de Gnome, se place en bas ou en haut)"
echo "[7] Disconnect Wifi (ajoute une option pour déconnecter/reconnecter rapidement le wifi)"
echo "[8] Gparte (permet de conserver du contenu copier/coller facilement accessible depuis le panel)"
echo "[9] Harddick Led (ajoute un aperçu de l'activité du disque dur)"
echo "[10] Hide Activities Button (simplement pour cacher le bouton 'Activités' situé en haut à gauche)"
echo "[11] Hide Top Bar (permet de cacher le panel en haut avec nombreux réglages possibles)"
echo "[12] Impatience (permet d'augmenter la vitesse d'affichage des animations de Gnome Shell)"
echo "[13] Log Out Button (ajouter un bouton de déconnexion pour gagner 1 clic en moins pour cette action)"
echo "[14] Media Player Indicator (ajouter un indicateur pour le contrôle du lecteur multimédia)"
echo "[15] Move Clock (déplace l'horloge du milieu vers la droite)"
echo "[16] Multi monitors add on (ajoute au panel un icone pour gérer rapidement les écrans)"
echo "[19] Openweather (Pour avoir la météo directement sur votre bureau)"
echo "[21] Places status indicator (Permet d'ajouter un raccourci vers les dossiers utiles dans le panel)"
echo "[22] Removable drive menu (Raccourci pour démonter rapidement les clés usb/support externe)"
echo "[24] Screenshot windows sizer (Permettre le redimensionnement des fenêtres pour Gnome-Screenshot)"
echo "[25] Shortcuts (Permet d'afficher un popup avec la liste des raccourcis possibles)"
echo "[27] Suspend button (Ajout d'un bouton pour activer l'hibernation)"
echo "[28] Taskbar (Permet d'ajouter des raccourics d'applis directement sur le panel en haut)"
echo "[29] Tilix dropdown (pour lancer Tilix en mode Quake. Ajoute un raccourci clavier avec F10)"
echo "[32] Trash (Ajoute un raccourci vers la corbeille dans le panel en haut)"
echo "[33] User themes (Pour charger des thèmes pour Gnome Shell à partir du répertoire de l'utilisateur)"
echo "[34] Window list (Affiche la liste des fênêtres en bas du bureau, comme à l'époque sous Gnome 2)"
echo "[35] Workspace indicator (Affiche dans le panel en haut dans quel espace de travail vous êtes)"
echo "[36] Redshift (Ajoute un raccourci pour basculer avec redshift dans le menu de l'utilisateur)"
echo "[37] System-monitor (Moniteur de ressource visible directement depuis le bureau)"
echo "[38] WindowNavigator (Permettre la sélection au clavier des fenêtres/espace de travail via la superposition)"
echo "[39] Top Icons Plus (Permet d'afficher un icone de notification pour les applis en haut à droite)"
read -p "Répondre par le ou les chiffres correspondants (exemple : 1) : " choixExtension
clear

# Question A13 : Prog
echo "*******************************************************"
echo "A13/ Quel éditeur de texte ou logiciel de Dev (IDE) veux-tu ?"
echo "*******************************************************"
echo "[1] Aucun (en dehors de Gedit présent de base et Vim qui sera installé car indispensable)"
echo "[2] Gvim (interface graphique pour Vim)"
echo "[3] Emacs (le couteau suisse des éditeurs de texte, il fait tout mais il est complexe)"
echo "[4] Geany (EDI rapide et simple utilisant GTK2 supportant de nombreux languages)"
echo "[5] PyCharm (IDE spécialisé pour le language Python)"
echo "[6] Visual Studio Code (Développé par Microsoft, sous licence libre MIT)"
echo "[7] Atom (Éditeur sous licence libre qui supporte les plug-ins Node.js et implémente GitControl)"
echo "[8] Brackets (Éditeur opensource d'Adobe pour le web design et dev web HTML, CSS, JavaScript...)"
echo "[9] Sublime Text (Logiciel développé en C++ et Python prenant en charge 44 languages de prog)"
echo "[10] Code:Blocks (IDE spécialisé pour le language C/C++)"
echo "[11] IntelliJ Idea (IDE Java commercial de JetBrains, plutôt conçu pour Java)"
echo "[12] JEdit (Éditeur libre, multiplateforme et très personnalisable)"
echo "[13] Eclipse (Projet décliné en sous-projets de développement, extensible, universel et polyvalent)"
echo "[14] Anjuta (IDE simple pour C/C++, Java, JavaScript, Python et Vala)"
echo "[15] Kdevelop (IDE gérant de nombreux language conçu plutôt pour KDE)" #==> vérifier pertinence sous Gnome...
echo "[16] Android Studio (IDE de Google spécialisé pour le développement d'application Android)"
echo "[17] Netbeans (EDI supportant plusieurs langage, surtout Java, avec de nombreux plugins)"
echo "[18] BlueFish (éditeur orienté développement web : HTML/PHP/CSS/...)"
echo "[19] BlueGriffon (éditeur HTML/CSS avec aperçu du rendu en temps réel)"
echo "[20] SciTE : Scintilla Text Editor (éditeur web avec une bonne coloration syntaxique)"

read -p "Répondre par le ou les chiffres correspondants (exemple : 4 5) : " choixDev
clear

# Question A14 : Serveur 
echo "*******************************************************"
echo "A14/ Des fonctions serveurs à activer ?"
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

# Question A15 : Optimisation
echo "*******************************************************"
echo "A15/ Des optimisations supplémentaires à activer ?"
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
echo "[11] Ajouter le support pour le système de fichier exFat de Microsoft"
echo "[12] Ajouter le support pour le système de fichier HFS d'Apple"
read -p "Répondre par le ou les chiffres correspondants (exemple : 2 3 7) : " choixOptimisation
clear


### Section installation automatisé

## Les choses utiles recommandés pour tous :

# Activation du dépot partenaire 
sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

#Maj du système + nettoyage
apt update ; apt full-upgrade -y ; apt autoremove --purge -y ; apt clean

# Utilitaires 
apt install net-tools vim htop gparted gnome-tweak-tool -y

# Suppression de l'icone Amazon
apt remove ubuntu-web-launchers -y

# Désactivation de l'affichage des messages d'erreurs à l'écran
echo "enabled=0" > /etc/default/apport


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
            wget http://download1.operacdn.com/pub/opera/desktop/48.0.2685.52/linux/opera-stable_48.0.2685.52_amd64.deb
            dpkg -i opera-stable_48.0.2685.52_amd64.deb
            apt install -fy
         ;;
         "11") #palemoon (si marche pas, faire avec le paquet deb)
            sh -c "echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser/xUbuntu_17.04/ /' > /etc/apt/sources.list.d/palemoon.list"
            apt update ; apt install palemoon -y 
         ;;
         "12") #vivaldi x64
            wget -nv https://download.opensuse.org/repositories/home:stevenpusser/xUbuntu_17.04/Release.key -O Release.key
            apt-key add - < Release.key ; apt update
            wget https://downloads.vivaldi.com/stable/vivaldi-stable_1.12.955.42-1_amd64.deb
            dpkg -i vivaldi-stable_1.12.955.42-1_amd64.deb
         ;;
         "13") #Falkon/Qupzilla
            apt install qupzilla -y
         ;;
         "14") #Tor browser
            apt install torbrowser-launcher -y
         ;;
         "15") #Eolie via Flatpak
            apt install flatpak -y
            wget https://flathub.org/repo/appstream/org.gnome.Eolie.flatpakref
            flatpak install --from ./org.gnome.Eolie.flatpakref -y
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
           
            ;;
        "5") #psi
            apt install psi -y
            ;;         
        "6") #gajim
            apt install gajim -y
            ;;
        "7") #skype
            
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
        "12") #teamspeak
            
            ;;       
        "13") #discord
            
            ;;                         
        "14") #tox
            apt install tox -y
            ;;               
        "15") #viber
            
            ;;               
        "16") #telegram
            
            ;;              
        "17") #wire
            
            ;;               
        "18") #hexchat
            apt install hexchat hexchat-plugins -y
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
        "6") #µTorrent
            
            ;;
        "7") #Bittorrent
            apt install bittorrent -y
            ;;            
        "8") #Vuze
           
            ;;           
        "9") #aMule
            apt install amule -y
            ;;           
        "10") #FrostWire
            
            ;;        
        "11") #Gtk-Gnutella
            apt install gtk-gnutella -y
            ;;    
        "12") #EiskaltDC++
            apt install eiskaltdcpp eiskaltdcpp-gtk3 -y
            ;;       
        "13") #RetroShare
            
            ;;                         
        "14") #Calypso
            
            ;;               
        "15") #Grsync
            apt install grsync -y
            ;;               
        "16") #SubDownloader
            apt install subdownloader -y
            ;;              
        "17") #Nicotine+ 
            apt install nicotine -y
            ;;               
        "18") #JDownloader
            
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
        "3") #MPV (mpv ou gnome-mpv ???)
            
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
            apt install banshee banshee-community-extensions -y
            apt install banshee-extension-radiostationfetcher banshee-extension-duplicatesongdetector banshee-extension-appindicator banshee-extension-albumartwriter -y
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
        "11") #Guayadeque
            
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
            apt install xmms2 xmms2-plugin-all -y
            ;;              
        "17") #Lollypop 
            
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
            apt install kdenlive -y
            ;;
        "6") #OpenShot Video Editor
            apt install openshot openshot-doc -y
            ;;
        "7") #Pitivi
            apt install pitivi -y
            ;;
        "8") #Lives
            
            ;;         
        "9") #EKD
            
            ;;
        "10") #Shotcut

            ;;            
        "11") #SlowMoVideo
            
            ;;           
        "12") #Flowblade
            apt install flowblade -y
            ;;           
        "13") #Cinelerra
            
            ;;        
        "14") #Natron
            
            ;;    
        "15") #LightWorks
    
            ;;       
        "16") #VLMC
            
            ;;                         
        "17") #Avidemux
            
            ;;               
        "18") #Mencoder
            apt install mencoder -y
            ;;               
        "19") #MMG MkvMergeGui
            
            ;;              
        "20") #DeVeDe 
            apt install devede -y
            ;;     
        "21") #Jahshaka
            
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
           
            ;;
        "6") #Phatch
            apt install phatch phatch-cli -y
            ;;
        "7") #Cinepaint
            
            ;;
        "8") #MyPaint
            apt install mypaint mypaint-data-extras -y
            ;;         
        "9") #ImageMagick
            
            ;;
        "10") #Ufraw
            apt install ufraw ufraw-batch -y
            ;;            
        "11") #Inkscape
            apt install inkscape -y
            ;;           
        "12") #sK1
            
            ;;           
        "13") #Darktable
            apt install darktable -y
            ;;        
        "14") #Art Of Illusion
            
            ;;    
        "15") #Blender
            apt install blender -y
            ;;       
        "16") #K-3D
            apt install k3d -y
            ;;                         
        "17") #SweetHome 3D
            apt install sweethome3d sweethome3d-furniture sweethome3d-furniture-nonfree -y
            ;;               
        "18") #LibreCAD
            apt install librecad -y
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
           
            ;;
        "4") #SoundJuicer
            apt install sound-juicer -y
            ;;
        "5") #SoundKonverter
           
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
            
            ;;
        "10") #RipperX
            apt install ripperx -y
            ;;            
        "11") #Grip
            
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
    esac
done

# Q10/ Utilitaire
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
            
            ;;
        "5") #Glances
            apt install glances -y
            ;;
        "6") #Brasero
            apt install brasero brasero-cdrkit nautilus-extension-brasero
            ;;
        "7") #Wine
            
            ;;
        "8") #Oracle Java
            
            ;;         
        "9") #FlashPlayer (avec dépot partenaire)
            apt install adobe-flashplugin -y
            ;;
        "10") #VirtualBox
            apt install virtualbox virtualbox-ext-pack -y
            ;;            
        "11") #VMWare Workstation Player
            
            ;;                                           
    esac
done

# Q11/ Jeux
for gaming in $choixGaming
do
    case $gaming in
        "2") #Steam
            apt install steam -y
            ;;
        "3") #PlayOnLinux
            apt install playonlinux -y
            ;;
        "4") #Minecraft
            
            ;;
        "5") #Minetest + mods (à tester)
            apt install minetest minetest-mod-* -y
            ;;
        "6") #OpenArena
            apt install openarena -y
            ;;
        "7") #0ad: Empires Ascendant
            apt install 0ad -y
            ;;
        "8") #Ryzom
            
            ;;         
        "9") #FlightGear
            apt install flightgear -y
            ;;
        "10") #SuperTux
            apt install supertux -y
            ;;            
        "11") #SuperTuxKart
            apt install supertuxkart -y
            ;;   
        "12") #Assault Cube
            apt install assaultcube -y
            ;;         
        "13") #World Of Padman
            
            ;;
        "14") #Second Life

            ;;            
        "15") #Gnome Games (verifier si gg-app utile)
            apt install gnome-games gnome-games-app -y
            ;;  
    esac
done


# Mode avancé : ne pas oublier d'ajouter plus tard une condition => Si mode avancé alors...

# A12/ Extensions
for extension in $choixExtension
do
    case $extension in
        "2") #
            
            ;;
        "3") #
           
            ;;
        "4") #
            
            ;;
        "5") #
           
            ;;
        "6") #
            
            ;;
        "7") #
            
            ;;
        "8") #
            
            ;;         
        "9") #
            
            ;;
        "10") #

            ;;            
        #.................                                       
    esac
done

# A13/ Programmation/Dev
for dev in $choixDev
do
    case $dev in
        "2") #Gvim
            
            ;;
        "3") #Emacs
            apt install emacs -y
            ;;
        "4") #Geany (verifier les extensions)
            
            ;;
        "5") #PyCharm
           
            ;;
        "6") #Visual Studio Code
            
            ;;
        "7") #Atom
            
            ;;
        "8") #Brackets
            
            ;;         
        "9") #Sublime Text
            
            ;;
        "10") #Code:Blocks
            apt install codeblocks codeblocks-contrib -y
            ;;           
        "11") #IntelliJ Idea
            
            ;;
        "12") #JEdit
            apt instakk jedit -y
            ;;
        "13") #Eclipse
            
            ;;
        "14") #Anjuta
            apt install anjuta anjuta-extras -y
            ;;
        "15") #develop
            
            ;;
        "16") #Android Studio
            
            ;;
        "17") #Netbeans
            
            ;;         
        "18") #BlueFish
            apt install bluefish bluefish-plugins -y
            ;;
        "19") #BlueGriffon

            ;;         
        "20") #SciTE
            apt install scite -y
            ;;  
    esac
done

# A14/ Serveurs
for srv in $choixServeur
do
    case $srv in
        "2") #openssh-server
            apt install openssh-server -y
            ;;
        "3") #apache+mariadb+php
            
            ;;
        "4") #proftpd
            apt install proftpd gadmin-proftpd -y
            ;;
        "5") #Postgresql
           
            ;;
        "6") #Oracle
            
            ;;
        "7") #Retroportage PHP5
            
            ;;
    esac
done


# A15/ Optimisation/Réglage
for srv in $choixServeur
do
    case $srv in
        "2") #déportage snappy ds Home
            
            ;;
        "3") #Swapiness 95%
           
            ;;
        "4") #Désactiver swap
            
            ;;
        "5") #Activer TLP + install Powertop
           
            ;;
        "6") #Microcode Intel
            
            ;;
        "7") #Police d'écriture Microsoft
            
            ;;
        "8") #Mode fraude Wayland
            
            ;;
        "9") #Désactiver userlist GDM
            
            ;;
        "10") #théme gris GDM
            
            ;;
        "11") #Support ExFat
            
            ;;
        "12") #Support HFS
            
            ;;
    esac
done

# Nettoyage/Purge
apt install -fy ; apt autoremove --purge -y ; apt clean ; clear

echo "Pour prendre en compte tous les changements, il faut maintenant redémarrer !"
read -p "Voulez-vous redémarrer immédiatement ? [o/n] " reboot
if [ "$reboot" = "o" ] || [ "$reboot" = "O" ]
then
    reboot
fi
