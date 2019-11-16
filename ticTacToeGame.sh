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
	echo ${position[6]}
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
		firstTurn=$playerLetter
	else
		firstTurn=$computerLetter
	fi
	playGame $firstTurn $playerLetter $computerLetter	
}
function playGame()
{
	turn=$1
	actualPosition="$( displayBoard )"
	determineWinnerTieOrChangeTurn $actualPosition $turn
}
function determineWinnerTieOrChangeTurn()
{
	boardPosition=$1
	Turn=$2
	if [ ${boardPosition[0]} -eq $Turn ] && [ ${boardPosition[1]} -eq $Turn ] && [ ${boardPosition[2]} -eq $Turn ]
	then
		result="win"
	elif [ ${boardPosition[3]} -eq $Turn ] && [ ${boardPosition[4]} -eq $Turn ] && [ ${boardPosition[5]} -eq $Turn ]
	then 
		result="win"
	elif [ ${boardPosition[6]} -eq $Turn ] && [ ${boardPosition[7]} -eq $Turn ] && [ ${boardPosition[8]} -eq $Turn ]
	then
		result="win"
	elif [ ${boardPosition[0]} -eq $Turn ] && [ ${boardPosition[3]} -eq $Turn ] && [ ${boardPosition[6]} -eq $Turn ]
	then
		result="win"
	elif [ ${boardPosition[1]} -eq $Turn ] && [ ${boardPosition[4]} -eq $Turn ] && [ ${boardPosition[7]} -eq $Turn ]
	then
		result="win"
	elif [ ${boardPosition[2]} -eq $Turn ] && [ ${boardPosition[5]} -eq $Turn ] && [ ${boardPosition[8]} -eq $Turn ]
	then
		result="win"
	elif [ ${boardPosition[0]} -eq $Turn ] && [ ${boardPosition[4]} -eq $Turn ] && [ ${boardPosition[8]} -eq $Turn ]
	then
		result="win"
	elif [ ${boardPosition[2]} -eq $Turn ] && [ ${boardPosition[5]} -eq $Turn ] && [ ${boardPosition[8]} -eq $Turn ]
	then
		result="win"
	elif [ ${boardPosition[0]} -eq 1 ] || [ ${boardPosition[1]} -eq 2 ] || [ ${boardPosition[2]} -eq 3 ] ||[ ${boardPosition[3]} -eq 4 ] || [ ${boardPosition[4]} -eq 5 ] || [ ${boardPosition[5]} -eq 6 ][ ${boardPosition[6]} -eq 7 ] || [ ${boardPosition[7]} -eq 8 ] || [ ${boardPosition[8]} -eq 9 ]
	then
		result="next turn"
	else
		result="tie"
	fi
	
}
main
 
