

Step 1 - Create a network
Important: Verify variables file - variables.tf

    ./terraform/build.sh terraform/network/ init
    ./terraform/build.sh terraform/network/ plan
    ./terraform/build.sh terraform/network/ apply
       
Step 2 - Create Keys
Important: Verify variables file - variables.tf


    ./terraform/build.sh terraform/keys/ init
    ./terraform/build.sh terraform/keys/ plan
    ./terraform/build.sh terraform/keys/ apply


Step 3 - Create MySQL Security Group
Important: Verify variables file - variables.tf

    ./terraform/build.sh terraform/docker/securityGroup/ init
    ./terraform/build.sh terraform/docker/securityGroup/ plan
    ./terraform/build.sh terraform/docker/securityGroup/ apply

Step 4 - Create instances Docker Swarm
Important: Verify variables file - variables.tf

    ./terraform/build.sh terraform/docker/ec2/ init
    ./terraform/build.sh terraform/docker/ec2/ plan
    ./terraform/build.sh terraform/docker/ec2/ apply

Step 5 - Create Load Balance - Docker Traefik

Security Group

    ./terraform/build.sh terraform/load_balance/securityGroup/ init
    ./terraform/build.sh terraform/load_balance/securityGroup/ plan
    ./terraform/build.sh terraform/load_balance/securityGroup/ apply

Load Balance

    ./terraform/build.sh terraform/load_balance/config/ init
    ./terraform/build.sh terraform/load_balance/config/ plan
    ./terraform/build.sh terraform/load_balance/config/ apply



       