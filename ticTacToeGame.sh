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
		computerPlay="play"
		while [ $computerPlay == play ] 
		do
			computerPosition="$( possibleWinningPosition $1 $2 $3 )"
			
			if [ ${position[$computerPosition]} == $computerPosition ]
			then
				position[$computerPosition]=$3
				displayBoard
				winner1="$( determineWinnerTieOrChangeTurn $3 )"
				computerPlay=dontPlay
				if [ $winner1 == true ]
				then
					echo "COMPUTER WON"
					break
				fi
			fi
		done  
		if [ $winner1 == true ]
		then
			break
		fi
	done

}

function possibleWinningPosition(){
	rowPosition="$( winAtRowPosition $1 $2 $3)"
	columnPosition="$( WinAtColoumnPosition $1 $2 $3 )"
	diagonalPosition="$( winAtDiagonalPosition $1 $2 $3 )"

	if [[ $rowPosition -gt 0 ]]
	then
		pos=$rowPosition
		positionToReplace=0;
	elif [[ $columnPosition -gt 0 ]]
	then
		pos=$columnPosition
		positionToReplace=0;
	elif [[ $diagonalPosition -gt 0 ]]
	then
		pos=$diagonalPosition
		positionToReplace=0;
	else
		pos=$((RANDOM%9+1))
	fi
	echo $pos
}

function determineWinnerTieOrChangeTurn()
{
	Turn=$1
	rowResult="$( checkRowForWinner $1)"
	columnResult="$( checkColumnForWinner $1)"
	diagonalsResult="$( checkDiagonalForWinner $1  )"
	flag=false	
	if [ $rowResult == true ] || [ $columnResult == true ] || [ $diagonalsResult == true ]
	then
		flag=true
	fi
	echo $flag
}
function checkRowForWinner()
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
function checkColumnForWinner()
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
function checkDiagonalForWinner()
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

function winAtRowPosition(){
	local computerLetter=$3
	local playerLetter=$2
	local row=0;
	local winner=false;
	for (( count=1; count<=3; count++ ))
	do
		row=$(( $row+1 ))
		if [[ ${position[$row]} == ${position[$row+1]} ]] || [[ ${position[$row+1]} == ${position[$row+2]} ]] || [[ ${position[$row+2]} == ${position[$row]} ]]
		then
			for (( innerLoopCounter=$row; innerLoopCounter<=$row+2; innerLoopCounter++ ))
			do
				if [[ ${position[$innerLoopCounter]} -ne $computerLetter ]] || [[ ${position[$innerLoopCounter]} -ne $playerLetter ]]
				then
					positionToReplace=$innerLoopCounter
				fi
			done
		else
			row=$(( $row+2 ))
		fi
	done
	echo $positionToReplace
}

function WinAtColoumnPosition(){
	local playerLetter=$2
	local computerLetter=$3
	local column=0;
	local winner=false;
	for (( count=1; count<=3; count++ ))
	do
		column=$(( $column+1 ))
		if [[ ${position[$column]} == ${position[$column+3]} ]] || [[ ${position[$column+3]} == ${position[$column+6]} ]] || [[ ${position[$column+6]} == ${position[$column]} ]] 
		then
			for (( innerLoopCounter=1; innerLoopCounter<=3; innerLoopCounter++ ))
			do
				if [[ ${position[$column]} -ne $computerLetter ]] || [[ ${position[$column]} -ne $playerLetter ]]
				then
					positionToReplace=$coloumn
				fi
				column=$(( $column+3 ))
			done
		fi
	done
	echo $positionToReplace
}

function winAtDiagonalPosition(){
	local playerLetter=$2
	local computerLetter=$3
	local diagCount=1;
	local count=1;
	local winner=false;
	if [[ ${position[$diagCount]} == ${position[$diagCount+4]} ]] || [[ ${position[$diagCount+4]} == ${position[$diagCount+8]} ]] || [[ ${position[$diagCount+8]} == ${position[$diagCount]} ]]
	then
		for (( innerLoopCounter=1; innerLoopCounter<=3; innerLoopCounter++ ))
		do
			if [[ ${position[$diagCount]} -ne $computerLetter ]] || [[ ${position[$diagCount]} -ne $playerLetter ]]
			then
				positionToReplace=$diagCount
			fi
			diagCount=$(( $diagCount+4 ))
		done
	elif [[ ${position[$count+2]} == ${position[$count+4]} ]] || [[ ${position[$count+4]} == ${position[$count+6]} ]] || [[ ${position[$count+6]} == ${position[$count+2]} ]]
	then
		for (( innerLoopCounter=1; innerLoopCounter<=3; innerLoopCounter++ ))
		do
			count=$(( $count+2 ))
			if [[ ${position[$count]} -ne $computerLetter ]] || [[ ${position[$count]} -ne $playerLetter ]]
			then
				positionToReplace=$count
			fi
		done
	fi
	echo $positionToReplace
}

function checkForTie()
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

main
