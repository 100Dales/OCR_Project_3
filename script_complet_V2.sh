#!/bin/bash -ex

# Renseigner l'adresse IP

read -p "Entrer l'adresse IP du poste concerné (ex: 192.168.100.X pour la salle Abeille ou 192.168.101.X pour la salle Baobab : " ADRESSE
IP=$(echo $ADRESSE)
LAN=$(echo $ADRESSE | cut -d '.' -f3)
PC=$(echo $ADRESSE | cut -d '.' -f4)

if [ $LAN = "100" ]
then

ssh -T abeille@$IP <<'EOL'

  # Mise à jour du poste cible
     sudo -i
     apt update
     apt upgrade -y

  # Suppression de l'ancien utilisateur
    OLD_USER=$(cat /etc/passwd | grep "ABE*" | cut -d ':' -f1)
    if [ -n $OLD_USER ]
    then
        echo $OLD_USER
        userdel -f -r $OLD_USER
    fi

  # Création du futur utilisateur
    NEW_USER=$(echo ABE-$PC)
    echo $NEW_USER
    useradd -m -s /bin/bash $NEW_USER
    echo -e "P@ssw0rd!\nP@ssw0rd!" | (passwd --stdin $NEW_USER)

  # Création du nouveau hostname
    NEW_HOSTNAME=$(echo CLT-ABE-$PC)
    echo $NEW_HOSTNAME
    hostname $NEW_HOSTNAME
EOL


else

if [ $LAN = "101" ]
then

ssh -T baobab@$IP <<'EOL'

  # Mise à jour du poste cible
     sudo -i
     apt update
     apt upgrade -y

  # Suppression de l'ancien utilisateur
    OLD_USER=$(cat /etc/passwd | grep "BAO*" | cut -d ':' -f1)
    if [ -n $OLD_USER ]
    then
        echo $OLD_USER
        userdel -f -r $OLD_USER
    fi

  # Création du futur utilisateur
    NEW_USER=$(echo BAO-$PC)
    echo $NEW_USER
    useradd -m -s /bin/bash $NEW_USER
    echo -e "P@ssw0rd!\nP@ssw0rd!" | (passwd --stdin $NEW_USER)

  # Création du nouveau hostname
    NEW_HOSTNAME=$(echo CLT-BAO-$PC)
    echo $NEW_HOSTNAME
    hostname $NEW_HOSTNAME
EOL

fi



















