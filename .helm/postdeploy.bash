#!/bin/bash

sudo sed -i -e "/^.*joborgame-$shortenv\.loc.*$/d" /etc/hosts
echo `minikube ip`" joborgame-$shortenv.loc" | sudo tee -a /etc/hosts
