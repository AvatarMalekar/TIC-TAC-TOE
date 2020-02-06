
#!/bin/bash
echo "---------------------------------------------:WELLCOME TO TIC TAC TOE:--------------------------------------------------------"

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
	if [[ $strValue == $"XXX" ]]
	then
		if [[ $"X" == $userLetter ]]
		then
			echo "YOU WIN.."
		else
			echo "Computer Wins"
		fi
		exit 0
	elif [[ $strValue == $"OOO" ]]
	then
		if [[ $"O" == $userLetter ]]
		then
			echo "YOU WIN.."
		else
			echo "Computer Wins.."
		fi
		exit 0
	fi
}

function checkWinner(){
	local str
	local curentStatus
	((tieCounter++))
	if [ $tieCounter -gt 4 ] #4 IS MINIMUM MOVES TO WIN
	then
		for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
		do
			str=""
			for (( j=0; j<$NUMBER_OF_COLUMNS; j++ ))
			do
				str="$str${gameBoard[$i,$j]}"
			done
			displayWinner $str
		done
		for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
		do
			str=""
			for (( j=0; j<$NUMBER_OF_COLUMNS; j++ ))
			do
				str="$str${gameBoard[$j,$i]}"
			done
			displayWinner $str
		done
		str=""
		for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
		do
			for (( j=0; j<$NUMBER_OF_COLUMNS; j++ ))
			do
				if [ $i -eq $j ]
				then
					str="$str${gameBoard[$i,$j]}"
				fi
			done
		done
		displayWinner $str
		str=""
		for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
		do
			for (( j=$((2-$i)); j<$NUMBER_OF_COLUMNS; j++ ))
			do
				str="$str${gameBoard[$i,$j]}"
				break;
			done
		done
		displayWinner $str
		if [ $tieCounter -gt 8 ] # 8 IS NUMBER OF BLOCKS IN TIC-TAC-TOE
		then
			echo "Its a Tie..Both Played Well.."
			exit 0
		fi
	fi
	if [[ $str != $"XXX" && $str != "OOO" ]]
	then
		echo "change in tern"
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
			if [ $(($i%2)) -eq 0 ]
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

function initialize(){
	x=0
	y=0
	counter1=0
	counter2=0
}

function insertValue(){
	local p=$1
	local q=$2
	local setLetter=$3
	gameBoard[$p,$q]=$setLetter
	retFlag=1
	flag2=1
}

function setValue(){
	local p=$1
	local q=$2
	local letterToMatch=$3
	if [[ ${gameBoard[$p,$q]} == $letterToMatch ]]
	then
		((counter1++))
	fi
	if [[ ${gameBoard[$p,$q]} == $"." ]]
	then
		x=$p
		y=$q
		((counter2++))
	fi
}

function checkBoard(){
	local fillLetter=$1
	local checkLetter=$2
	retFlag=0
	flag2=0
	if [ $flag2 -eq 0 ]
	then
	for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
	do
		initialize
		for (( j=0; j<$NUMBER_OF_COLUMNS; j++ ))
		do
			setValue $i $j $checkLetter
		done
		if [ $counter1 -eq 2 -a $counter2 -eq 1 ]
		then
			insertValue $x $y $fillLetter
		fi
	done
	fi

	if [ $flag2 -eq 0 ]
	then
	for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
	do
		initialize
		for (( j=0; j<$NUMBER_OF_COLUMNS; j++ ))
		do
			setValue $j $i $checkLetter
		done
		if [ $counter1 -eq 2 -a $counter2 -eq 1 ]
		then
			insertValue $x $y $fillLetter
		fi
	done
	fi

	if [ $flag2 -eq 0 ]
	then
	initialize
	for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
	do
		for (( j=0; j<$NUMBER_OF_COLUMNS; j++ ))
		do
			if [ $i -eq $j ]
			then
				setValue $i $j $checkLetter
			fi
		done
		if [ $counter1 -eq 2 -a $counter2 -eq 1 ]
		then
			insertValue $x $y $fillLetter
		fi
	done
	fi

	if [ $flag2 -eq 0 ]
	then
	initialize
	for (( i=0; i<$NUMBER_OF_ROWS; i++ ))
	do
		for (( j=$((2-$i)); j<$NUMBER_OF_COLUMNS; j++ ))
		do
			setValue $i $j $checkLetter
			break;
		done
		if [ $counter1 -eq 2 -a $counter2 -eq 1 ]
		then
			insertValue $x $y $fillLetter
		fi
	done
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

boardReset
userLetter=$(getAssignedLetter)
computerLetter=$(getComputerLetter $userLetter )
gameBoardDisplay
echo "User letter::"$userLetter
echo "Computer letter::"$computerLetter
startGame
