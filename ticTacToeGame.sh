#!/bin/bash 

echo "******Wel-Come To TicTacToe Game******"

declare -a position

function initializedBoardArray()
{
	for(( i=1; i<=9; i++ ))
	do
		position[$i]=$i
	done

}

function displayBoard()
{
	i=1
	for(( counter=0; counter<3; counter++ ))
	do
		echo "|     |     |     |"
		echo "|" ${position[$((i))]}"   | "${position[$((i+1))]}"   |" ${position[$((i+2))]}"   |"
		echo "|_____|_____|_____|"
		i=$(($((i+1))+2))
	done
	echo "\n"
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
	computerPlay=play
	userPlay=play
	while [ $toContinue == 0 ]
	do
		userPlay="play"
		while [ $userPlay == play ]
		do
			read -p "Enter the Cell Number" pos
			position[$pos]=$2 
			displayBoard
			winner="$( determineWinnerTieOrChangeTurn $2 )"
			userPlay=dontPlay				
			if [ $winner == true ]
			then
				echo "PLAYER WON"
				break;
			fi
				

		done
		if [ $winner == true ]
		then
			break;
		fi
  
	done

}

function determineWinnerTieOrChangeTurn()
{
	Turn=$1
	rowResult="$( checkRow $1)"
	columnResult="$( checkColumn $1)"
	diagonalsResult="$( checkDiagonal $1  )"
	flag=false	
	if [ $rowResult == true ] || [ $columnResult == true ] || [ $diagonalsResult == true ]
	then
		flag=true
	fi
	echo $flag
}
function checkRow()
{
	local letter=$1
	local rowCount=0;
	local winner=false;
	for (( count=1; count<=3; count++ ))
	do
		rowCount=$(( $rowCount+1 ))
		if [[ ${position[$rowCount]} == ${position[$rowCount+1]} ]] && [[ ${position[$rowCount+1]} == ${position[$rowCount+2]} ]]
		then
			winner=true;
			break;
		else
			rowCount=$(( $rowCount+2 ))
		fi
	done
	echo $winner
}
function checkColumn()
{
	local letter=$1	
	local columnCount=0;
	local winner=false;
	for (( count=1; count<=3; count++ ))
	do
		columnCount=$(( $columnCount+1 ))
		if [[ ${position[$columnCount]} == ${position[$columnCount+3]} ]] && [[ ${position[$columnCount+3]} == ${position[$columnCount+6]} ]]
		then
			winner=true;
			break;
		fi
	done
	echo $winner
}
function checkDiagonal()
{
	local letter=$1
	local winner=false
	for (( count=1; count<=3; count++ ))
	do
		if [[ ${position[$count]} == ${position[$count+4]} ]] && [[ ${position[$count+8]} == $letter ]] && [[ ${position[$count]} == $letter ]]
		then
			winner=true;
			break;
		elif [[ ${position[$count+2]} == ${position[$count+4]} ]] && [[ ${position[$count+6]} == $letter ]] && [[ ${position[$count+2]} == $letter ]]
		then
			winner=true;
			break;
		fi
	done
	echo $winner;

}


function tie()
{
	i=0
	result4=tie
	for (( i=0; i<9; i++))
	do
		if [ ${position[$i]} == $((i+1)) ] 
		then
			result4="next"
		fi
	done
	echo $result4
}
function rowWinningPosition()
{
	return $((RANDOM%9+1))
	

}
main
