#!/bin/bash -x
echo "---------------------------------------------:WELLCOME TO TIC TAC TOE:--------------------------------------------------------"
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3
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

boardReset
userLetter=$(getAssignedLetter)
