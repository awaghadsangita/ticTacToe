#!/bin/bash -x 

echo "******Wel-Come To TicTacToe Game******"

position[0]=1
position[1]=2
position[2]=3
position[3]=4
position[4]=5
position[5]=6
position[6]=7
position[7]=8
position[8]=9


function displayBoard()
{
	echo "|     |     |     |"
	echo "|" ${position[0]}"   | "${position[1]}"   |" ${position[2]}"   |"
	echo "|_____|_____|_____|"
	echo "|     |     |     |"
	echo "|" ${position[3]}"   | "${position[4]}"   |" ${position[5]}"   |"
	echo "|_____|_____|_____|"
	echo "|     |     |     |"
	echo "|" ${position[6]}"   | "${position[7]}"   |" ${position[8]}"   |"
	echo "|     |     |     |"
}
function main()
{
	read -p "Player Choose letter(x or 0) for playing " playerLetter
	if [ $playerLetter == x ] || [ $playerLetter == X ]
	then
		computerLetter=0
	else
		computerLetter=x
	fi
	firstTurn=$((RANDOM%2))
	if [ $firstTurn -eq 1 ]
	then
		firstTurn="Player"
	else
		firstTurn="Computer"
	fi
	playGame $firstTurn	
}
function playGame()
{
	firstTurn=$1
	displayBoard
}
main
