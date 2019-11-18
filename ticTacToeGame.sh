#!/bin/bash 

echo "******Wel-Come To TicTacToe Game******"

declare -a position

function initializedBoardArray()
{
	for(( i=0; i<9; i++ ))
	do
		position[$i]=$(($i+1))
	done

}

function displayBoard()
{
	i=0
	for(( counter=0; counter<3; counter++ ))
	do
		echo "|     |     |     |"
		echo "|" ${position[$((counter+i))]}"   | "${position[$((counter+i+1))]}"   |" ${position[$((counter+i+2))]}"   |"
		echo "|     |     |     |"
		i=$((counter+3))
	done
}
function main()
{
	initializedBoardArray
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
		firstTurn=$playerLetter
	else
		firstTurn=$computerLetter
	fi

	if [ $firstTurn == $playerLetter ]
	then
		read -p "Enter the cell number" pos
		position[$((pos-1))]=$playerLetter
		displayBoard 
	fi
}

main
 
