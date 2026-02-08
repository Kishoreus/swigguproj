#!/bin/bash
set -e
SERVER_IP=$(hostname -I | awk '{print $1}')

echo "===== Installing Jenkins + SonarQube on same server ====="

# Update
yum update -y

# Java 17
yum install java-17-amazon-corretto unzip wget -y

# ------------------------
# JENKINS INSTALL
# ------------------------
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

yum install jenkins -y

systemctl daemon-reexec
systemctl start jenkins
systemctl enable jenkins

echo "Jenkins installed"

# ------------------------
# POSTGRESQL FOR SONARQUBE
# ------------------------
amazon-linux-extras install postgresql14 -y
yum install postgresql-server -y

/usr/bin/postgresql-setup initdb
systemctl start postgresql
systemctl enable postgresql

sudo -u postgres psql <<EOF
CREATE DATABASE sonarqube;
CREATE USER sonar WITH ENCRYPTED PASSWORD 'sonar';
GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonar;
EOF

# ------------------------
# SONARQUBE INSTALL
# ------------------------
useradd sonar || true

cd /opt
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.4.87374.zip
unzip sonarqube-9.9.4.87374.zip
mv sonarqube-9.9.4.87374 sonarqube

chown -R sonar:sonar /opt/sonarqube

cat <<EOF > /opt/sonarqube/conf/sonar.properties
sonar.jdbc.username=sonar
sonar.jdbc.password=sonar
sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube
sonar.web.port=9000
EOF

# Kernel limits (mandatory)
cat <<EOF >> /etc/sysctl.conf
vm.max_map_count=262144
fs.file-max=65536
EOF

sysctl -p

cat <<EOF >> /etc/security/limits.conf
sonar   -   nofile   65536
sonar   -   nproc    4096
EOF

# Start SonarQube
su - sonar -c "/opt/sonarqube/bin/linux-x86-64/sonar.sh start"

echo "===== INSTALLATION COMPLETE ====="
echo ""
echo "Jenkins URL    : http://$SERVER_IP:8080"
echo "SonarQube URL  : http://$SERVER_IP:9000"
echo ""
echo "Jenkins Admin Password:"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo ""
echo "SonarQube Default Login: admin / admin"
