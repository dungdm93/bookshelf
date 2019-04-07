# OpenShift Ansible installer

## INSTRUCTION

```shell
sudo -i
usermod -l dungdm93 vagrant
exit

cp -R /tmp/ssh ~/.ssh
gcloud init

cd ~/app/reference-architecture/gcp
./ocp-on-gcp.sh -vvv
```
