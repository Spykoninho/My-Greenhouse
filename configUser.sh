#!/bin/bash
echo "Login :"
read -p "Username or email : " USERNAME
read -s -p "Password : " PWD;
response=$(curl -d -f "username=$USERNAME&password=$PWD" "$API_IP_HOST/api/login")
jwt=$($response | jq -r '.jwt')
if [ $jwt -eq "" ]; then
    echo "Erreur : Impossible de récupérer le JWT depuis l'API."
    exit 1
fi


sudo sed -i '/JWT=/d' /etc/environment # delete the actual var if already exist
echo "JWT=$jwt" | sudo tee -a /etc/environment # put it in /etc/environment, tee is like >> but with the sudo right

echo "JWT added, wait the reboot..."
sleep 1
sudo reboot