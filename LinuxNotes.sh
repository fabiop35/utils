#LINUX - NOTES

#VNCSERVER
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-20-04
> vim ~/.vnc/xstartup
	#!/bin/bash
    xrdb $HOME/.Xresources
    startxfce4 &

> vncserver -geometry 3048x1568
  vncserver -geometry 1900x1040
  vncserver -geometry 1910x960
> export DISPLAY=localhost:1
> /opt/netbeans/bin/netbeans &
> vncserver -kill :1

#To start firefox when error
> mv ~/.Xauthority /home







export DISPLAY=localhost:1

sudo apt-get install xfce4-terminal #ToDo


https://thelinuxforum.com/articles/919-how-to-install-gui-on-ubuntu-24-04-server 

#timeout
/var/snap/docker/common/var-lib-docker/volumes/minikube/_data/lib/kubelet/config.yaml - streamingConnectionIdleTimeout 


kubectl -n default exec -it catalog-service curl -v localhost:8080
minikube ssh curl -v 172.17.0.23:82

##mint
#ssh
sudo apt update && sudo apt install openssh-server
sudo ufw allow ssh
sudo systemctl enable ssh
sudo systemctl status ssh

#Change timezone
$ sudo timedatectl set-timezone America/Bogota


























