

# Infrastructure Diagram
![infrastructure diagram](https://raw.githubusercontent.com/confy/3640-final-project/main/infra_diagram.png)

# RDS


The first time the RDS is created, it will need to be populated manually.

After this first time, a snapshot of the database will need to be created. 

From that point on, the RDS will be populated automatically. 

Here are the steps for creating the User and populating the Database/Tables:

* Create a new ec2 instance with ssh access in a public subnet in our custom VPC
* SSH into the instance
* Install the mysql client: 

```
sudo yum install mysql
```

* Download the social_something database:

```
wget https://raw.githubusercontent.com/sam-meech-ward-bcit/social_something_full/master/database.sql
```

* Login to the database using the hostname, admin-user, and admin-password - In my case:

```  
mysql -u admin -p -h ss-database.csjefxiksrp2.us-east-1.rds.amazonaws.com 
```
*The db hostname appears in the terraform apply output*

* In MySql now, source the social_something database:
```
source database.sql
```
* Now create a new user with access only on the network and grant privileges.
```
CREATE USER 'web-app'@'172.31.%.%' IDENTIFIED WITH mysql_native_password BY 'YOUR_PASSWORD';
GRANT ALL PRIVILEGES ON social_something.* TO 'web-app'@'172.31.%.%';
```

* ??? profit
