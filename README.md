# A Simple Terraform Project

This repo holds a small file that I wrote in order to learn about automating infrastructure using Terraform and Microsoft Azure. It basically:

1. Creates a Resource Group with a randomly-generated identifier;
2. Creates an App Service in that Resource Group;
3. Turns on logging for the App Service;
4. Builds a NodeJS application from source (a GitHub repo I cloned and modified slightly);
5. Runs that Node app in the App Service;
6. Lets you send variables to your Terraform plan to start and stop the App Service;
7. Lets you send variables to your Terraform plan to switch which branch of the app is the currently deployed one;

For reference, I started by using [these instructions,](https://docs.microsoft.com/en-us/azure/app-service/provision-resource-terraform) and expanded on them from there.
