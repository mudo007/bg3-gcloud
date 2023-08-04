# Baldur's gate 3 VM setup scripts 

Inspired by: https://www.youtube.com/watch?v=aJDU5L8-iog and due to the fact thar BG3 will be released for mac's only in september 2023, I created this teraform script to setup a proper VM on Google Cloud that should be decent enough for all the project 100h playthrough with the $300 free credit that every new user gets

Connecting to the VM with RDP/Parsec and installing the game is beyond the scope of this tutorial

In order to start the VM, the steps are:
1. Log into the google cloud shell and clone this repo 
2. Create a .env file at the project root with the content:
```
TF_VAR_PROJID=your-project-id-here
TF_VAR_REGION=us-central1-c
```
You can easily fetch your projectid on the gcloud interface

3. Start the VM with the provided script
```
./start_vm.sh
```
4. Once you are done playing stop it with the stop script
```
./stop_vm.sh
```

It is very important to stop the VM if you are not playing, as it is billed by hour. If you forget to turn it off, your credits might get drained quickly
