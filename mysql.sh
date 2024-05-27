#!/bin/bash

source ./common.sh

check_root
#when you're calling function it shouldnt have () brackets

echo "Please enter DB password:"
read -s mysql_root_password

dnf install mysql-server -y &>>$LOGFILE


systemctl enable mysqld &>>$LOGFILE


systemctl start mysqld &>>$LOGFILE


# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
# VALIDATE $? "Setting up root password"

#below code will be usefull for idempotent nature
mysql -h db.manishadaws.online -uroot -p${mysql_root_password} -e 'SHOW DATABASES;' &>>$LOGFILE
if [ $? -ne 0 ]
then
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE

else
echo -e "MySqll root password is already setup..$Y SKIPPING $N"
fi


