#!/bin/bash


#Create a project
oc create namespace myproject


#Switch to the project
oc project myproject


#Add cluster roles for the project admininstrator.
#Run this command to provide access to system service account for openshift-infra:template-instance-controller.
oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:openshift-infra:template-instance-controller
#Run this command to provide access to system service account for <projectname> as default.
oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:myproject:default


cd /root/power-openstack-k8s-volume-driver/template


#Install security constraints
if [ -f scc.yaml ]; then
	echo "scc.yaml file exist"
else
	echo "scc.yaml file doesn't exist"
fi
oc apply -f scc.yaml
if [ $? -eq 0 ]; then
	echo "scc.yaml installed"
else
	echo "scc.yaml doesn't installed"
exit 1;
fi


#Make the following changes to template file and install it
if [ -f ibm-powervc-csi-driver-template.yaml ]; then
	echo "ibm-powervc-csi-driver-template.yaml file exist"
else
	echo "ibm-powervc-csi-driver-template.yaml file doesn't exist"
fi
oc apply -f ibm-powervc-csi-driver-template.yaml
if [ $? -eq 0 ]; then
        echo "ibm-powervc-csi-driver-template.yaml installed"
else
        echo "ibm-powervc-csi-driver-template.yaml doesn't installed"
exit 1;
fi


#Make the following changes to template file and install it
if [ -f secret.yaml ]; then
        echo "secret.yaml file exist"
else
        echo "secret.yaml file doesn't exist"
fi
oc apply -f secret.yaml
if [ $? -eq 0 ]; then
        echo "secret.yaml installed"
else
        echo "secret.yaml doesn't installed"
exit 1;
fi


#Process the template file.
oc process ibm-powervc-csi -p OPENSTACK_IP_OR_HOSTNAME=<ip or hostname> -p OPENSTACK_CRED_SECRET_NAME=my-secret > <a>.yaml


#Install all OpenShift artifacts.
if [ -f a.yaml ]; then
	echo "a.yaml file exist"
else
	echo "a.yaml file doesn't exist"
fi
oc apply -f a.yaml
if [ $? -eq 0 ]; then
	echo "artifacts installed successfully"
else
	echo "artifacts installation failed"
exit 1;
fi
