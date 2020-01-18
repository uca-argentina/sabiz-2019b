"
This class represents the turn handler of the game. It can give the game the information about which player has to play next
"
Class {
	#name : #TurnAllocator,
	#superclass : #Object,
	#instVars : [
		'turnWheel',
		'currentTurn',
		'currentRound'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnAllocator class >> for: participants [
	self
		assert: participants isNotEmpty
		description: 'Cant create TurnAllocator for an empty group'.
	^ self new initializeFor: participants
]

{ #category : #advancing }
TurnAllocator >> advanceTurnWheel [
	currentTurn isNil ifTrue: [ ^ nil ].
	turnWheel lastRolledIndex = (turnWheel sequenceSize - 1)
		ifTrue: [ currentRound := currentRound + 1 ].
	currentTurn := turnWheel roll.
	^ currentTurn
]

{ #category : #accessing }
TurnAllocator >> currentRoundNumber [
	^ currentRound
]

{ #category : #initialization }
TurnAllocator >> initializeFor: participants [
	turnWheel := SequentialDice withSequence: participants.
	currentTurn := turnWheel roll.
	currentRound := 1
]

{ #category : #alteringWheel }
TurnAllocator >> playerHasFinished: player [
	turnWheel sequenceSize = 1
		ifTrue: [ currentTurn := nil ]
		ifFalse: [ turnWheel removeFromSequence: player ]
]

{ #category : #accessing }
TurnAllocator >> playerWhoseTurnItIsToPlay [
	^ currentTurn
]
