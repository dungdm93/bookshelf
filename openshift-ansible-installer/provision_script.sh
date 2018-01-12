yum install -y \
    curl python which tar \
    qemu-img openssl git ansible \
    python-libcloud python2-jmespath \
    java-1.8.0-openjdk-headless httpd-tools python2-passlib;

pip install -U apache-libcloud;

cat <<EOM > /etc/yum.repos.d/google-cloud-sdk.repo
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
        https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

yum install -y google-cloud-sdk;

export USERNAME="dungdm93"
export PASSWORD="superpower"

adduser ${USERNAME};
usermod -aG wheel ${USERNAME};
echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USERNAME};
