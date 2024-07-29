#!/bin/bash
echo "Installation des dépendances..."
sudo apt-get install jq -y > /dev/null

echo "Login :"
echo "----"
read -p "Username or email : " USERNAME
read -s -p "Password : " PWD;
echo ""

response=$(curl -sS -f -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "username=$USERNAME&password=$PWD" "$API_IP_HOST/api/login" 2>&1)
status=$?
if [ $status -ne 0 ]; then
    echo "Error during getting the jwt."
    exit 1
fi

jwt=$(echo $response | jq -r '.jwt')
if [ -z $jwt ]; then
    echo "Error during getting the jwt."
    exit 1
fi
sudo sed -i '/JWT=/d' /etc/environment # delete the actual var if already exist
echo "JWT=$jwt" | sudo tee -a /etc/environment > /dev/null # put it in /etc/environment, tee is like >> but with the sudo right

if [ $? -ne 0 ]; then
    echo "Error writing JWT to /etc/environment."
    exit 1
fi

echo ""
echo "JWT added, add your greenhouse :"
echo "----"
read -p "Greenhouse name: " GREENHOUSE;

response2=$(curl -sS -f -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Authorization: $jwt" -d "greenhouse_name=$GREENHOUSE" "$API_IP_HOST/api/addGreenhouse" 2>&1)
statusGreenhouse=$?
if [ $statusGreenhouse -ne 0 ]; then
    echo "Error during adding the greenhouse."
    exit 1
fi

greenhouse_id=$(echo $response2 | jq -r '.id')
if [ -z $greenhouse_id ]; then
    echo "Error during getting the greenhouse id"
    exit 1
fi

sudo sed -i '/GREENHOUSE_ID=/d' /etc/environment # delete the actual var if already exist
echo "GREENHOUSE_ID=$greenhouse_id" | sudo tee -a /etc/environment > /dev/null # put it in /etc/environment, tee is like >> but with the sudo right
if [ $? -ne 0 ]; then
    echo "Error writing GREENHOUSE_ID to /etc/environment."
    exit 1
fi
echo "Greenhouse id added, wait the reboot..."
sleep 1
sudo reboot