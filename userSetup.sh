#!/bin/bash
# Testing stage begin
# Script: userSetup.sh


function createUser() {
	#echo -e "TESTING CREATEUSER STANDBY\n"
	echo -e "\tWELCOME TO THE USER CREATING SETUP WIZARD\n"
	echo -e "\tPLEASE ENTER A USERNAME"
	read nameOfUser
	sudo adduser $nameOfUser

	echo -e "\tTHE USER HAS SUCCESSFULLY BEEN CREATED\n"
	echo -e "\tYOU TAKE CARE!"
}


function viewUserList() {
	echo -e "TESTING viewUserList STANDBY\n"
	echo -e "ALRIGHT LET THE PROCESS BEGIN"
	echo -e "GENERATING USER LIST NOW.....\n"
	awk -F':' '{print $1}' /etc/passwd | tail -5

	echo -e "THAT WILL BE ALL\n"
}


function deleteUser() {
	echo -e "TESTING deleteUser STANDBY\n"
	awk -F':' '{print $1}' /etc/passwd | tail -5
	echo -e "\tAbove is a list of recently added users\n"
	echo -e "Please enter the user you want to delete: "
	read userName

	# When deleting user accounts make sure to kill off any process
	# That is currently using the user account that you wish to delete.

	sudo pkill -u $userName
	sudo deluser --force --remove-home $userName

	cat /etc/passwd | tail -5

	echo -e "\nTHE USER HAS BEEN DELETED!!!\n GOODBYE!\n"
}

# Initial start of the script.
# Stage 1: Let the game's begin! Muahahaha...
echo "Greetings Admin"
echo -e "Below is a list of options for you to execute\n"
echo "1) CREATE USER ACCOUNT"
echo "2) CHECK HOW MANY USER'S EXITS"
echo "3) DELETE USER ACCOUNT"
echo "4) EXIT THE MENU"

# Stage 2: ACQUIRE INPUT
echo -e "\tPLEASE CHOOSE AN OPTION: "
read option

#Stage 3: SWITCH CASE SELECTION... PLEASE GO WELL.
case $option in
	"1")
		echo -e "\tBegin creating user account\n"
		createUser
		;;
	"2")    echo -e "\tChecking to see list of users\n"
		viewUserList
		;;
	"3")    echo -e "\tDELETE USER ACCOUNT\n"
		deleteUser
		;;
	"4")    echo -e "\tEXITING MAIN MENU\n"
		echo -e "\tSAYONARA!!!!\n"
		;;
esac

