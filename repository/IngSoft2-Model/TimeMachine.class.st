"
Go back to the starting position of your last turn, if the game just started, just go back to the starting position
"
Class {
	#name : #TimeMachine,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #'standard values' }
TimeMachine class >> probability [
	^ 8
]

{ #category : #effect }
TimeMachine >> applyEffectOn: gameState triggeredBy: player [
	(gameState sizeOfPlayerStateForPlayer: player) = 2
		ifTrue: [ gameState
				saveStateOfPlayer: player
				withNewLapNumber: 0
				andNewPosition: 1 ]
		ifFalse: [ gameState
				saveStateOfPlayer: player
				withNewLapNumber: (gameState previousLapOfPlayer: player)
				andNewPosition: (gameState previousPositionOfPlayer: player) ]
]
