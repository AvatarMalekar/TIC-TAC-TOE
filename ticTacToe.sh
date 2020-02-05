#!/bin/bash
echo "---------------------------------------------:WELLCOME TO TIC TAC TOE:--------------------------------------------------------"

#CONSTANT
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3
PLAYER=0
X=0
O=1

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

function checkWinner(){
	local str=""
	local curentStatus
	((tieCounter++))
	if [ $tieCounter -gt 4 ] #4 IS MINIMUM MOVES TO CHECK WINNER
	then
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
				if [[ $"X" == $userLetter ]]
				then
					echo "YOU WIN.."
				else
					echo "Computer Wins"
				fi
				exit 0
			elif [[ $str == $"OOO" ]]
			then
				if [[ $"O" == $userLetter ]]
				then
					echo "YOU WIN.."
				else
					echo "Computer Wins.."
				fi
				exit 0
			fi
		done
		if [ $tieCounter -gt 8 ] #8 IS TIE CONDITION
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
	retFlag=1
	local fillLetter=$1
	if [[ ${gameBoard[0,0]} == $"." ]]
	then
		gameBoard[0,0]=$fillLetter
	elif [[ ${gameBoard[2,2]} == $"." ]]
	then
		gameBoard[2,2]=$fillLetter
	elif [[ ${gameBoard[2,0]} == $"." ]]
	then
		gameBoard[2,0]=$fillLetter
	elif [[ ${gameBoard[0,2]} == $"." ]]
	then
		gameBoard[0,2]=$fillLetter
	else
		retflag=0
	fi
}

function takeCenter(){
	retFlag=1
	local fillLetter=$1
	if [[ ${gameBoard[1,1]} == $"." ]]
	then
		gameBoard[1,1]=$fillLetter
	else
		retflag=0
	fi
}

function takeSides(){
	retFlag=1
	if [[ ${gameBoard[1,0]} == $"." ]]
	then
		gameBoard[1,0]=$fillLetter
	elif [[ ${gameBoard[0,1]} == $"." ]]
	then
		gameBoard[0,1]=$fillLetter
	elif [[ ${gameBoard[1,2]} == $"." ]]
	then
		gameBoard[1,2]=$fillLetter
	elif [[ ${gameBoard[2,1]} == $"." ]]
	then
		gameBoard[2,1]=$fillLetter
	else
		retflag=0
	fi
}

function checkBoard(){
	local fillLetter=$1
	local checkLetter=$2
	retFlag=1
	if [[ ${gameBoard[0,0]} == $checkLetter && ${gameBoard[0,1]} == $checkLetter && ${gameBoard[0,2]} == $"." ]]
	then
		gameBoard[0,2]=$fillLetter
	elif [[ ${gameBoard[1,0]} == $checkLetter && ${gameBoard[1,1]} == $checkLetter && ${gameBoard[1,2]} == $"." ]]
	then
		gameBoard[1,2]=$fillLetter
	elif [[ ${gameBoard[2,0]} == $checkLetter && ${gameBoard[2,1]} == $checkLetter && ${gameBoard[2,2]} == $"." ]]
	then
		gameBoard[2,2]=$fillLetter
	elif [[ ${gameBoard[0,1]} == $checkLetter && ${gameBoard[0,2]} == $checkLetter && ${gameBoard[0,0]} == $"." ]]
	then
		gameBoard[0,0]=$fillLetter
	elif [[ ${gameBoard[1,1]} == $checkLetter && ${gameBoard[1,2]} == $checkLetter && ${gameBoard[1,0]} == $"." ]]
	then
		gameBoard[1,0]=$fillLetter
	elif [[ ${gameBoard[2,1]} == $checkLetter && ${gameBoard[2,2]} == $checkLetter && ${gameBoard[2,0]} == $"." ]]
	then
		gameBoard[2,0]=$fillLetter
	elif [[ ${gameBoard[0,0]} == $checkLetter && ${gameBoard[1,0]} == $checkLetter && ${gameBoard[2,0]} == $"." ]]
	then
		gameBoard[2,0]=$fillLetter
	elif [[ ${gameBoard[0,1]} == $checkLetter && ${gameBoard[1,1]} == $checkLetter && ${gameBoard[2,1]} == $"." ]]
	then
		gameBoard[2,1]=$fillLetter
	elif [[ ${gameBoard[0,2]} == $checkLetter && ${gameBoard[1,2]} == $checkLetter && ${gameBoard[2,2]} == $"." ]]
	then
		gameBoard[2,2]=$fillLetter
	elif [[ ${gameBoard[1,0]} == $checkLetter && ${gameBoard[2,0]} == $checkLetter && ${gameBoard[0,0]} == $"." ]]
	then
		gameBoard[0,0]=$fillLetter
	elif [[ ${gameBoard[1,1]} == $checkLetter && ${gameBoard[2,1]} == $checkLetter && ${gameBoard[0,1]} == $"." ]]
	then
		gameBoard[0,1]=$fillLetter
	elif [[ ${gameBoard[1,2]} == $checkLetter && ${gameBoard[2,2]} == $checkLetter && ${gameBoard[0,2]} == $"." ]]
	then
		gameBoard[0,2]=$fillLetter
	elif [[ ${gameBoard[0,0]} == $checkLetter && ${gameBoard[1,1]} == $checkLetter && ${gameBoard[2,2]} == $"." ]]
	then
		gameBoard[2,2]=$fillLetter
	elif [[ ${gameBoard[1,1]} == $checkLetter && ${gameBoard[2,2]} == $checkLetter && ${gameBoard[0,0]} == $"." ]]
	then
		gameBoard[0,0]=$fillLetter
	elif [[ ${gameBoard[2,0]} == $checkLetter && ${gameBoard[1,1]} == $checkLetter && ${gameBoard[0,2]} == $"." ]]
	then
		gameBoard[0,2]=$fillLetter
	elif [[ ${gameBoard[1,1]} == $checkLetter && ${gameBoard[0,2]} == $checkLetter && ${gameBoard[2,0]} == $"." ]]
	then
		gameBoard[2,0]=$fillLetter
	elif [[ ${gameBoard[1,0]} == $checkLetter && ${gameBoard[1,2]} == $checkLetter && ${gameBoard[1,1]} == $"." ]]
	then
		gameBoard[1,1]=$fillLetter
	elif [[ ${gameBoard[0,1]} == $checkLetter && ${gameBoard[2,1]} == $checkLetter && ${gameBoard[1,1]} == $"." ]]
	then
		gameBoard[1,1]=$fillLetter
	elif [[ ${gameBoard[0,0]} == $checkLetter && ${gameBoard[2,2]} == $checkLetter && ${gameBoard[1,1]} == $"." ]]
	then
		gameBoard[1,1]=$fillLetter
	elif [[ ${gameBoard[2,0]} == $checkLetter && ${gameBoard[0,2]} == $checkLetter && ${gameBoard[1,1]} == $"." ]]
	then
		gameBoard[1,1]=$fillLetter
	elif [[ ${gameBoard[0,0]} == $checkLetter && ${gameBoard[0,2]} == $checkLetter && ${gameBoard[0,1]} == $"." ]]
	then
		gameBoard[0,1]=$fillLetter
	elif [[ ${gameBoard[2,0]} == $checkLetter && ${gameBoard[2,2]} == $checkLetter && ${gameBoard[2,1]} == $"." ]]
	then
		gameBoard[2,1]=$fillLetter
	elif [[ ${gameBoard[0,0]} == $checkLetter && ${gameBoard[2,0]} == $checkLetter && ${gameBoard[1,0]} == $"." ]]
	then
		gameBoard[1,0]=$fillLetter
	elif [[ ${gameBoard[0,2]} == $checkLetter && ${gameBoard[2,2]} == $checkLetter && ${gameBoard[1,2]} == $"." ]]
	then
		gameBoard[1,2]=$fillLetter
	else
		retFlag=0
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
