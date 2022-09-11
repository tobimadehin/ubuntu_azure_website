# ubuntu_azure_website  
Provision a static html page that runs on ubuntu VMs in azure.    

The project was done in a docker container on Ubuntu LTS 18.04.

The initialization of cloud instances was done with cloud-init.

This project utilizes azure load balancing feature to create a highly available software.

## Deployment steps
### Pre-requisites
1. An azure account
2. A docker runtime

### Steps
1. Clone the project to your machine

2. Login to the azure cl ```sudo az login``` 

3. Deploy the ```deploy.sh``` script
```sudo bash deploy.sh```

4. Copy the public ip from the terminal into your address bar
```http://<-public ip->```

5. ubuntu_azure_website should be up and running

6. If you run into any issues while executing any of these steps, simply create a case

Cheers!
