PowerVC CSI
Step1:- Pre-requisites.

Follow the documentation : http://blaze.aus.stglabs.ibm.com/kc20A-bld/SSXK2N_1.4.4/com.ibm.powervc.standard.help.doc/powervc_csi_storage_install.html , and complete the below steps manually.

a. Download the following files from GitHub location, on to /root on the Bastion node.

ibm-powervc-csi-driver-template.yaml

scc.yaml

secret.yaml

b. Need to modify ibm-powervc-csi-driver-template.yaml template file

For OPENSTACK_CERT_DATA, copy the contents of powervc.crt file, <<< Location:- /etc/pki/tls/certs/powervc.crt
For DRIVER_VOLUME_TYPE, enter the name or UUID of the storage template.

c. Edit the secret.yaml file.

Replace OS_USERNAME and OS_PASSWORD parameters of secret file with your PowerVC username and password encrypted in base 64 format. Use the following command to get base64 encrypted format

$ base64 <<< <enter-your-powervc-username>
$ base64 <<< <enter-your-powervc-password>

d. Modify csi.sh script and provide the IP address of hostname of the PowerVC server.
step2:- The actual execution of the script.

a. Give the csi.sh file permission.

chmod 777 csi.sh

b. Execute the script.

./csi.sh

step3:- Verification.

After installing csi driver, you need to verify if the installation is successful or not.

Check if all pods are in good state

Check the list of csinodes

$ oc get csinodes
