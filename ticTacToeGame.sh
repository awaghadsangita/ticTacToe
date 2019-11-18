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
		echo "|" ${position[$((i))]}"   | "${position[$((i+1))]}"   |" ${position[$((i+2))]}"   |"
		echo "|_____|_____|_____|"
#		echo "|     |     |     |"
		i=$(($((i+1))+2))
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
		playGame $firstTurn $playerLetter $computerLetter
	else
		firstTurn=$computerLetter
		playGame $firstTurn $playerLetter $computerLetter
	fi

}
function playGame()
{
	toContinue=0
	turn=$2
	while [ $toContinue == 0 ]
	do
		read -p "Enter the Cell Number" pos
		if [ ${position[$((pos-1))]} == $2 ] || [ ${position[$((pos-1))]} == $3 ]
		then
			toContinue=0
		else
			position[$((pos-1))]=$turn 
			displayBoard
			toContinue="$( determineWinnerTieOrChangeTurn $turn )"
		fi
	done
	
}

function determineWinnerTieOrChangeTurn()
{
	Turn=$1
	rowResult="$( checkRow $1 )"
	columnResult="$( checkColumn $1 )"
	diagonalsResult="$( checkDiagonal $1 )"
	
	if [ $rowResult == "win" ] || [ $columnResult == "win" ] || [ $diagonalsResult == "win" ]
	then
		flag=1
	else
		tieResult="$( tie )"		
		if [ $tieResult == next ]
		then
			flag=0
		fi
	fi
	echo $flag
}
function checkRow()
{
	letter=$1
	result1=next
	for(( i=0; i<3; i++ ))
	do
		if [ ${position[$i]} == $letter ] && [ ${position[$i+1]} == $letter ] && [ ${position[$i+2]} == $letter ]
		then
			result1="win"
			break;
		fi
	done
	echo $result1
}
function checkColumn()
{
	letter=$1
	result2=next
	for(( i=0; i<3; i++ ))
	do
		if [ ${position[$i]} == $letter ] && [ ${position[$i+3]} == $letter ] && [ ${position[$i+6]} == $letter ]
		then
			result2="win"
			break;
		fi
	done
	echo $result2
}
function checkDiagonal()
{
	letter=$1
	i=0
	result3=next
	if [ ${position[$i]} == $letter ] && [ ${position[$i+4]} == $letter ] &&  [ ${position[$i+8]} == $letter ]
	then
		result3="win"
	fi
	if [ ${position[$i+2]} == $letter ] && [ ${position[$i+4]} == $letter ] &&  [ ${position[$i+6]} == $letter ]
	then
		result3="win"
	fi
	echo $result3
}

function tie()
{
	i=0
	result4=tie
	if [ ${position[$i]} == 1 ] || [ ${position[$i+1]} == 2 ] ||  [ ${position[$i+2]} == 3 ] || [ ${position[$i+3]} == 4 ] || [ ${position[$i+5]} == 5 ] || [ ${position[$i+6]} == 6 ] || [ ${position[$i+7]} == 7 ] || [ ${position[$i+8]} == 8 ] || [ ${position[$i+9]} == 9 ]
	then
		result4="next"
	fi
	echo $result4

}
main
