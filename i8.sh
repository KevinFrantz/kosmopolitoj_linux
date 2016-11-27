#!/bin/bash
RED='\033[0;31m'
LIGHTRED='\033[0;31m'
NC='\033[0m'
BLUE='\033[0;34m'
LIGHTBLUE='\033[1;34m'
YELLOW='\033[1;33m'
LIGHTGREEN='\033[1;32m'
LIGHTCYAN='\033[1;36m'
LIGHTPURPLE='\033[1;35m'
DARKGRAY='\033[1;30m'

LINE="-------------------------------------------------------------------------"
# Mehr Infos: http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
echo
echo -------------------------------------------------------------------------
echo -e "${LIGHTBLUE}Infinito.one - i8"
echo -e "${NC}Viva la Kosmopolitoj - Es braucht eine Software für die Revolution!"
echo 
echo -e "${YELLOW}Struktrieren um zu Organisieren."
echo -e "${YELLOW}Organisieren um zu Gestalten."
echo -e "${YELLOW}Gestalten um Menschsein zu verwirklichen!"
echo 
echo -e "${NC}In diesem Sinne: ${RED}Viva la Revolution!${NC}"
echo 
echo -e "${NC}Technologien: 	${LIGHTPURPLE}MariaDB, MySQL, PHP, HTML, jQuery, Javascript"
echo 
echo -e "${NC}@since		${LIGHTPURPLE}Oktober 2015"	
echo -e "${NC}@author		${LIGHTPURPLE}Kevin Frantz"
echo
echo "Beachten: Tool muss via 'source i8.sh' aufgerufen werden!"  
echo -e "${NC}${LINE}"
echo
echo -e "${LIGHTGREEN}${LINE}"
echo -e Netbeans wird gestartet der Prozess wird im Hintergrund ausgeführt...
echo -e "${LINE}"
echo
/bin/sh "/usr/local/netbeans-8.2/bin/netbeans" & disown > /dev/null
echo -e "${BLUE}${LINE}"
echo -e "Scripts werden gemounted..."
echo -e "${LINE}"
echo
#echo -e 'Sollen die Linux-Scripte gemounted werden? Ja(j) oder Nein(n)?'
#sudo mount --bind /home/keveliene/.scripts/linux ~/Dokumente/development/web/infinito/src/mnt/scripts
echo -e "${LIGHTCYAN}${LINE}"
echo Vagrant wird gestartet...
echo -e "${LINE}"
echo
cd ~/Dokumente/development/web/infinito/vagrant-php7/
vagrant up
echo
echo -e "${YELLOW}${LINE}"
echo "Infinito wird in neuem Tab geöffnet..."
echo -e "${LINE}"
firefox -new-tab "localhost:8000" &> /dev/null
echo
echo -e "${NC}Es wird zum Git-Repo gewechselt..."
cd "../src"
echo
echo -e "${RED}${LINE}"
echo "Status des Git-Repository: "
echo -e "${LINE}${NC}"
echo 
git status
