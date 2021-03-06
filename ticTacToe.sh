#!/bin/bash
echo "----------------------------------------------:WELLCOME TO TIC TAC TOE:--------------------------------------------------------"

#CONSTANT
readonly NUMBER_OF_ROWS=3
readonly NUMBER_OF_COLUMNS=3
readonly PLAYER=0
readonly X=0
readonly O=1

#VARIABLES
tieCounter=0
declare -A gameBoard

#FUNCTIONS
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

function startGame(){
	local toss2=$((RANDOM%2))
	if [ $toss2 -eq $PLAYER ]
	then
		echo "Player Will Play first"
		humanPlayer
	else
		echo "Computer Will Play first"
		smartComputer
	fi

}

function gameBoardDisplay(){
	echo "-------------"
	for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
	do
		for (( j=0; j<$NUMBER_OF_COLUMNS; j++ ))
		do
			echo -n "|"
			printf " ${gameBoard[$i,$j]} "
		done
		echo "|"
		echo "-------------"
	done
}

function displayWinner(){
	local strValue=$1
	if [[	$strValue == $"XXX" || $strValue == $"OOO" ]]
	then
		if [[ $strValue == "$userLetter$userLetter$userLetter" ]]
		then
			echo "CONGRATULATIONS..!! YOU WON..!!"
		else
			echo "COMPUTER WON..!!"
		fi
		exit 0
	fi
}

function checkWinForAll(){
	str3=""
	str4=""
	counterDigonal=2
	for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
	do
		str1=""
		str2=""
		for (( j=0; j<$NUMBER_OF_COLUMNS; j++ ))
		do
			str1="$str1${gameBoard[$i,$j]}"
			str2="$str2${gameBoard[$j,$i]}"
			if [ $i -eq $j ]
			then
				str3="$str3${gameBoard[$i,$j]}"
			fi
		done
		str4="$str4${gameBoard[$i,$counterDigonal]}"
		((counterDigonal--))
		displayWinner $str1
		displayWinner $str2
		displayWinner $str3
		displayWinner $str4
	done
}

function checkWinner(){
	str=""
	local curentStatus
	((tieCounter++))
	if [ $tieCounter -gt 4 ] #4 IS MINIMUM MOVES TO WIN
	then
		checkWinForAll
		if [ $tieCounter -gt 8 ] # 8 IS NUMBER OF BLOCKS IN TIC-TAC-TOE
		then
			echo "Its a Tie..Both Played Well.."
			exit 0
		fi
	fi
	if [[ $str != $"XXX" && $str != "OOO" ]]
	then
		echo "change in turn"
	fi
}

function getComputerLetter(){
	local letter=$1
	if [[ $letter == $"X" ]]
	then
		echo $"O"
	else
		echo $"X"
	fi
}

function takeCorners(){
	retFlag=0
	local fillLetter=$1
	for (( i=0; i<$NUMBER_OF_ROWS; i=$(($i+2)) ))
	do
		for (( j=0; j<$NUMBER_OF_COLUMNS; j=$(($j+2)) ))
		do
			if [[ ${gameBoard[$i,$j]} == $"." ]]
			then
				gameBoard[$i,$j]=$fillLetter
				retFlag=1
				return
			fi
		done
	done
}

function takeCenter(){
	retFlag=1
	local fillLetter=$1
	if [[ ${gameBoard[1,1]} == $"." ]]
	then
		gameBoard[1,1]=$fillLetter
	else
		retFlag=0
	fi
}

function takeSides(){
	retFlag=0
	local fillLetter=$1
	for (( i=0; i<$(($NUMBER_OF_ROWS-1)); i++ ))
	do
		for (( j=0; j<$(($NUMBER_OF_COLUMNS-1)); j++ ))
		do
			if [ $(($j%2)) -eq 0 ]
			then
				if [[ ${gameBoard[$i,$(($i+1))]} == $"." ]]
				then
					gameBoard[$i,$(($i+1))]=$fillLetter
					retFlag=1
					return
				fi
			else
				if [[ ${gameBoard[$(($i+1)),$i]} == $"." ]]
				then
					gameBoard[$(($i+1)),$i]=$fillLetter
					retFlag=1
					return
				fi
			fi
		done
	done
}

function insertValue(){
	local p=$1
	local q=$2
	local setLetter=$3
	gameBoard[$p,$q]=$setLetter
	retFlag=1
}

function checkBoard(){
	local fillLetter=$1
	local checkLetter=$2
	local counterForDigo=2
	retFlag=0
	counter5=0
	counter6=0
	counter7=0
	counter8=0
	x=0
	y=0
	r=0
	s=0
	p=0
	q=0
	c=0
	n=0
	for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
	do
		counter1=0
		counter2=0
		counter3=0
		counter4=0
		for (( j=0; j<$NUMBER_OF_COLUMNS; j++ ))
		do
			if [[ ${gameBoard[$i,$j]} == $checkLetter ]]
			then
				((counter1++))
			fi
			if [[ ${gameBoard[$i,$j]} == $"." ]]
			then
				x=$i
				y=$j
				((counter2++))
			fi
			if [[ ${gameBoard[$j,$i]} == $checkLetter ]]
			then
				((counter3++))
			fi
			if [[ ${gameBoard[$j,$i]} == $"." ]]
			then
				r=$j
				s=$i
				((counter4++))
			fi
			if [ $i -eq $j ]
			then
				if [[ ${gameBoard[$i,$j]} == $checkLetter ]]
				then
					((counter5++))
				fi
				if [[ ${gameBoard[$i,$j]} == $"." ]]
				then
					p=$i
					q=$j
					((counter6++))
				fi
			fi
		done
		if [[ ${gameBoard[$i,$counterForDigo]} == $checkLetter ]]
		then
			((counter7++))
		fi
		if [[ ${gameBoard[$i,$counterForDigo]} == $"." ]]
		then
			c=$i
			n=$counterForDigo
			((counter8++))
		fi
		if [ $counter1 -eq 2 -a $counter2 -eq 1 ]
		then
			insertValue $x $y $fillLetter
			return
		fi
		if [ $counter3 -eq 2 -a $counter4 -eq 1 ]
		then
			insertValue $r $s $fillLetter
			return
		fi
		((counterForDigo--))
	done
	if [ $counter5 -eq 2 -a $counter6 -eq 1 ]
	then
		insertValue $p $q $fillLetter
		return
	fi
	if [ $counter7 -eq 2 -a $counter8 -eq 1 ]
	then
		insertValue $c $n $fillLetter
		return
	fi
}

function smartComputer(){
	retFlag=0
	if [ $retFlag -eq 0 ]
	then
		checkBoard $computerLetter $computerLetter
	fi
	if [ $retFlag -eq 0 ]
	then
		checkBoard $computerLetter $userLetter
	fi
	if [ $retFlag -eq 0 ]
	then
		takeCorners $computerLetter
	fi
	if [ $retFlag -eq 0 ]
	then
		takeCenter $computerLetter
	fi
	if [ $retFlag -eq 0 ]
	then
		takeSides $computerLetter
	fi
	gameBoardDisplay
	checkWinner
	humanPlayer
}

function humanPlayer(){
	local checkFlag=0
	while [ $checkFlag -eq 0 ]
	do
		read -p "Enter the position::" position
		i=$(($position/10))
		j=$(($position%10))
		if [[ ${gameBoard[$i,$j]} == $"." ]]
		then
			checkFlag=1
		else
			echo "Position is already occupied.."
		fi
	done
	gameBoard[$i,$j]=$userLetter
	gameBoardDisplay
	checkWinner
	smartComputer
}

#MAIN
boardReset
userLetter=$(getAssignedLetter)
computerLetter=$(getComputerLetter $userLetter )
gameBoardDisplay
echo "User letter::"$userLetter
echo "Computer letter::"$computerLetter
startGame
