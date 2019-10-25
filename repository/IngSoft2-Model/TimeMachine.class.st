"
Go back to the starting position of your last turn, if the game just started, just go back to the starting position
"
Class {
	#name : #TimeMachine,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
TimeMachine >> applyOn: gameState triggeredBy: player [
	(gameState sizeOfPlayerStateForPlayer: player) = 2
		ifTrue: [ gameState
				addStateFor: player
				withLaps: 0
				andPosition: 1 ]
		ifFalse: [ gameState
				addStateFor: player
				withLaps: (gameState previousLapOfPlayer: player)
				andPosition: (gameState previousPositionOfPlayer: player) ]
]
