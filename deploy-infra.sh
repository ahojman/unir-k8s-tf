#!/bin/bash

terraform -chdir=terraform apply -auto-approve
terraform -chdir=terraform output > outputs.txt