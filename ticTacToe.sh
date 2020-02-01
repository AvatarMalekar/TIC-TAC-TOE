#!/bin/bash -x
echo "---------------------------------------------:WELLCOME TO TIC TAC TOE:--------------------------------------------------------"
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3
PLAYER=0
COMPUTER=1
X=0
O=1

declare -a gameBoard

function boardReset(){
	for(( i=0; i<$NUMBER_OF_ROWS; i++ ))
	do
		for(( j=0; j<$NUMBER_OF_COLUMNS; j++ ))
		do
			gameBoard[$i,$j]="."	
		done
	done
}

function getAssignedLetter(){
	local toss=$((RANDOM%2))
	if [ $toss -eq $X ]
	then
		echo $"X"
	else
		echo $"O"
	fi
}
function whoWillPlayFirst(){
	local toss=$((RANDOM%2))
	if [ $toss -eq $PLAYER ]
	then
		echo $PLAYER
	else
		echo $COMPUTER
	fi

}

function gameBoardDisplay(){
	echo "-------------"
	for (( i=0; i<$NUMBER_OF_COLUMNS; i++ ))
	do
		for (( j=0; j<$NUMBER_OF_ROWS; j++ ))
		do
			echo -n "|"
			printf " ${gameBoard[$i,$j]} "
		done
		echo "|"
		echo "-------------"
	done
}

function checkWinner(){
	local str=""
	local curentStatus
	for (( i=0; i<8; i++ ))
	do
		case $i in
			0)
				str="${gameBoard[0,0]}${gameBoard[0,1]}${gameBoard[0,2]}"
				;;
			1)
				str="${gameBoard[1,0]}${gameBoard[1,1]}${gameBoard[1,2]}"
				;;
			2)
				str="${gameBoard[2,0]}${gameBoard[2,1]}${gameBoard[2,2]}"
				;;
			3)
				str="${gameBoard[0,0]}${gameBoard[1,0]}${gameBoard[2,0]}"
				;;
			4)
				str="${gameBoard[0,1]}${gameBoard[1,1]}${gameBoard[2,1]}"
				;;
			5)
				str="${gameBoard[0,2]}${gameBoard[1,2]}${gameBoard[2,2]}"
				;;
			6)
				str="${gameBoard[0,0]}${gameBoard[1,1]}${gameBoard[2,2]}"
				;;
			7)
				str="${gameBoard[2,0]}${gameBoard[1,1]}${gameBoard[0,2]}"
				;;
			*)
				echo "Invalid entry"
				;;
		esac
		if [[ $str == $"XXX" ]]
		then
			curentStatus="X"
			break;
		elif [[ $str == $"OOO" ]]
		then
			curentStatus="O"
			break
		else
			curentStatus="change in turn"
		fi
	done
	echo $curentStatus
}
boardReset
userLetter=$(getAssignedLetter)
firstTurnToPlay=$(whoWillPlayFirst)
gameBoardDisplay
gameStatus=$(checkWinner)
