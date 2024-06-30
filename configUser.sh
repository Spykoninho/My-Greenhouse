#!/bin/bash
echo "Login :"
read -p "Username or email : " USERNAME
read -s -p "Password : " PWD; echo
echo $API_IP_HOST/api/login
curl -d "username=$USERNAME&password=$PWD" "$API_IP_HOST/api/login"