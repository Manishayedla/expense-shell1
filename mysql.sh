#!/bin/bash

source ./common.sh

check_root
#when you're calling function it shouldnt have () brackets

echo "Please enter DB password:"
read -s mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
#VALIDATE $? "Installing MySQL Server"

systemctl enable mysqld &>>$LOGFILE
#VALIDATE $? "Enabling MySQL Server"

systemctl start mysqld &>>$LOGFILE
#VALIDATE $? "Starting MySQL Server"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
# VALIDATE $? "Setting up root password"

#below code will be usefull for idempotent nature
mysql -h db.manishadaws.online -uroot -p${mysql_root_password} -e 'SHOW DATABASES;' &>>$LOGFILE
if [ $? -ne 0 ]
then
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
#VALIDATE $? "MySQL root password is setup"
else
echo -e "MySqll root password is already setup..$Y SKIPPING $N"
fi


