#!/bin/bash
# SSH-Manager für das Kosmopolitoj-Netzwerk
# @author kf
# @since 2016-09-04

# Startet einen neuen SSH-Agent und setzt die entsprechenden Variablen
newSSH(){
	echo "Neuer SSH-Agent wird gestartet...";
	eval $(ssh-agent);
	echo "";
}

# Fügt einen SSH-Key hinzu
addKey(){
	echo "SSH-Schlüssel werden hinzugefügt...";
	ssh-add;
	ssh-add -l;
	echo "";
}

# Validiert die Verbindungsdaten:
#
# Folgende Parameter stehen zur Verfügung:
# $1: Servername\IP\Platzhalter
# $2: Nutzername 
# $3: Port
#
validateConnection(){
	if [ ! -z $1 ] 
		then
			#Server definieren wenn übergeben:
			connection = $1;
			if [ ! -z $2 ] 
				then
				#Nutzer definieren wenn übergeben:
				connection = "$connection@$2";
			fi;
			if [ ! -z $3 ] 
				then
				#Port definierne wenn übergeben:
				connection = "-p $3";
			fi;
		else
			echo "Das Script wurde mit einem FEHLER beendet. Es ist notwendig einen Severnamen zu übergeben!";
	fi
	#Validierte Verbindungsdaten zurückgeben:
	return $connection;
}

# Öffnet eine SSH-Verbindung
# Folgende Parameter stehen zur Verfügung:
# @param string $1 Verbindungsdaten - Können durch validate Connection validiert werden
openConnection(){
	echo "SSH-Verbindung wird etabliert...";
	eval "ssh $1";
	echo "";
}

# Mountet einen sshfs-Pfad:
# 
# @param string $1 Verbindungsdaten - Können durch validate Connection validiert werden
# @param string $2 Quellpfad - Der Quellpfad auf dem via SSH eingebundenen Server 
# @param string $3 Zielpfad - Der Zielpfad auf dem Clienten
addSshfs(){
	sshfs="sshfs $1:$2 $3"
	echo "Etabliere Verbindung via <$sshfs>";
	eval $sshfs;
	echo "";
}

#Gibt die Beschreibung zurück
printHead(){
    echo "-----------------------------";
    echo "Kosmopolitoj SSH-Manager";
    echo "";
    echo "Um das Programm zu verlassen benutzen Sie die Tastenkombination <Strg + Alt + C> .";
    echo "";
    echo "@autor kf";
    echo "@since 2016-11-26";
    echo "-----------------------------";
    echo "";
}

#Zeigt das allgemeine Menue an
menue(){
    echo "Serverauswahl:";
    servers=(dominodekosmopolitoj lenovo samsung ilo acer ftp);
    echo "";
    echo "Tip: Neue Server müssen in ~/.ssh hinterlegt werden!"
    echo "";
    echo "Bitte wählen Sie einen Server aus der nachfolgenden Liste aus: ";
    select server_name in ${servers[*]};
    do
    case $server_name in
            "dominodekosmopolitoj")
                server="0x02-raspi";
            break
            ;;
            *)
            echo "Der gewählte Server steht nicht zur Verfügung. Bitte geben Sie einen anderen Server ein."
            ;;
    esac
    done
    echo "";
    echo "Server <$server> wird verwendet.";
    echo "";
    #Aktion-Menü immer wieder aufrufen:
    while true
        do
        action_menue $server;
    done;
}

#Stellt eine SSH-sshuttle Verbindung zu einem Kosmopolitoj-Server her
sshuttle_kosmopolitoj(){
#!/bin/bash
echo "----------------------------------------------------------------"
echo "sshuttle - $1"
echo ""
echo "Port Forwarding auf den $1-Server"
echo "Um Portforwarding zu beenden <<Strg + Alt + C>> drücken"
echo ""
echo "@author kf"
echo "@since 2016-11-27"
echo "----------------------------------------------------------------"
sshuttle -r $1 0/0
}

#Kopiert eine Datei via SSH-SCP
# @param string $1 Der Servername
# @param string $3 Der Clientdateipfad
# @param string $3 Der Serverdateipfad
scp_kosmopolitoj(){
echo "----------------------------------------------------------------"
echo "scp - $1"
echo ""
echo "Kopiert den übergebenen Pfad(rekursiv) auf den $1-Server"
echo "Um Portforwarding zu beenden <<Strg + Alt + C>> drücken"
echo ""
echo "@author kf"
echo "@since 2016-11-27"
echo "----------------------------------------------------------------"
scp -v -r $2 $1:$3
}

#Führt eine bestimmte Aktion mit einem Server aus:
action_menue(){
    echo "Bitte geben Sie ein, was für eine Aktion Sie tätigen möchten: ";
    echo "Weitere Informationen über die unteren Befehle erhalten Sie in den Manpages";
    actions=("ssh" "sshuttle" "sshfs" "scp");
    select action_name in ${actions[*]};
    do
    case $action_name in
        "ssh")
            openConnection $1
        break
        ;;
        "sshfs")
            addSshfs $1 "/" "/media/sshfs/0x02-dominodekosmopolitoj";
        break
        ;;
        "sshuttle")
            sshuttle_kosmopolitoj $1;
        break
        ;;
        "scp")
            echo "Bitte geben Sie den Clientdateipfad ein:"
            read client_pfad
            echo "Bitte geben Sie den Serverpfad ein:"
            read server_pfad
            scp_kosmopolitoj $1 $client_pfad $server_pfad;
        break
        ;;
        *)
            echo "Der gewählte Dienst <$action_name> steht nicht zur Verfügung. Bitte wählen Sie einen anderen Dienst aus."
        ;;
        esac
        done
}

#Programmstart
clear;
printHead;
echo "Die SSH-Routine wird abgearbeitet..."
echo "";
newSSH;
addKey;
menue;


