echo -e "\e[36m>>>>>>>>> Install Python <<<<<<<<\e[0m"
dnf install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>>>> Add Application User <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create App Dir <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>>>> Download App Content <<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

echo -e "\e[36m>>>>>>>>> Extract App Content <<<<<<<<\e[0m"
cd /app
unzip /tmp/payment.zip

echo -e "\e[36m>>>>>>>>> Install Dependencies <<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>>>>Setup SystemD Service <<<<<<<<<\e[0m"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service
systemctl daemon-reload
systemctl enable payment
systemctl restart payment