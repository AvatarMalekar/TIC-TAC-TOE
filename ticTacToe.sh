#!/bin/bash -x
echo "---------------------------------------------:WELLCOME TO TIC TAC TOE:--------------------------------------------------------"
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3

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

boardReset
