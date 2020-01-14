"
This class represents the turn handler of the game. It can give the game the information about which player has to play next
"
Class {
	#name : #TurnAllocator,
	#superclass : #Object,
	#instVars : [
		'turnWheel',
		'currentTurn'
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
	currentTurn := turnWheel roll.
	^ currentTurn
]

{ #category : #accessing }
TurnAllocator >> currentTurn [
	^ currentTurn
]

{ #category : #initialization }
TurnAllocator >> initializeFor: participants [
	turnWheel := SequentialDice withSequence: participants.
	currentTurn := turnWheel roll
]
