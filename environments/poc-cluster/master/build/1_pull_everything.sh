#Ansible
apt-get update
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install ansible sshpass -y
apt install -y wamerican
apt-get upgrade -y

export ANSIBLE_HOST_KEY_CHECKING=False

#Conjur
curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.quickstart.yml
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key

#Jenkins
docker pull jenkins/jenkins:lts

#Kubernetes
cd /tmp
git clone https://github.com/QuincyChengAtWork/conjur-oss-k8s-authn-katacoda.git
wget https://github.com/QuincyChengAtWork/conjur-oss-k8s-authn-katacoda/archive/v1.0.zip
unzip v1.0.zip

# This script will be run when the container starts, before the user connects.
cat << 'EOF' > /opt/configure-environment.sh
#!/bin/bash
kubeadm init --token=102952.1a7dd4cc8d1f4cc5 --kubernetes-version $(kubeadm version -o short)
mkdir -p $HOME/.kube
cp -v /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
EOF
chmod +x /opt/configure-environment.sh
