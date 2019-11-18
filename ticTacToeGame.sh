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
initializedBoardArray
displayBoard
