https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine

sudo dpkg -i ./containerd.io_1.6.31-1_amd64.deb \
  ./docker-ce_26.0.0-1~ubuntu.24.04~noble_amd64.deb \
  ./docker-ce-cli_26.0.0-1~ubuntu.24.04~noble_amd64.deb \
  ./docker-buildx-plugin_0.13.1-1~ubuntu.24.04~noble_amd64.deb \
  ./docker-compose-plugin_2.26.1-1~ubuntu.24.04~noble_amd64.deb
  
  sudo service docker start
  
  https://phoenixnap.com/kb/install-kubernetes-on-ubuntu
   
   curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
   
   echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    
	sudo apt update
   
   sudo apt install kubeadm kubelet kubectl
   
   sudo apt-mark hold kubeadm kubelet kubectl
   kubeadm version
   
   ***minikube - CNSIA
   brew install minikube
   sudo usermod -aG docker user && newgrp docker
    minikube start --driver=docker
	minikube config set driver docker
	kubectl get nodes
	minikube stop
	kubectl get deployment
	kubectl get pod
	kubectl logs <pod_id>
	kubectl delete deployment <name>
	kubectl delete pod <name>
	kubectl delete svc <service>
	kubectl port-forward svc <service> <host-port>:<cluster-port>