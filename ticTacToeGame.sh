#!/bin/bash 

echo "******Wel-Come To TicTacToe Game******"

p1=1
p2=2
p3=4
p4=4
p5=5
p6=6
p7=7
p8=8
p9=9

function displayBoard()
{
	echo "|     |     |     |"
	echo "|" $p1"   | "$p2"   |" $p3"   |"
	echo "|_____|_____|_____|"
	echo "|     |     |     |"
	echo "|" $p4"   | "$p5"   |" $p6"   |"
	echo "|_____|_____|_____|"
	echo "|     |     |     |"
	echo "|" $p7"   | "$p8"   |" $p9"   |"
	echo "|     |     |     |"
			
}
displayBoard
