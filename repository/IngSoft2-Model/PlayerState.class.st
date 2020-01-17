"
This class contains information about the current state of a player, consisting of a lap number, the position of the player in the board, and the list of effects that are applied to him
"
Class {
	#name : #PlayerState,
	#superclass : #Object,
	#instVars : [
		'position',
		'lapNumber',
		'roundNumber',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerState class >> on: position and: lapNumber and: roundNumber holding: cards [
	self
		assert: position > 0
		description: 'A player cant be on a position lower than 1'.
	^ self new
		on: position
		and: lapNumber
		and: roundNumber
		holding: cards asOrderedCollection
]

{ #category : #'instance creation' }
PlayerState class >> on: position and: lapNumber holding: cards [
	"Used to create the first state"
	^ self on: position and: lapNumber and: 0 holding: cards
]

{ #category : #comparing }
PlayerState >> > aState [
	self lapNumber == aState lapNumber
		ifTrue: [ ^ self position > aState position ]
		ifFalse: [ ^ self lapNumber > aState lapNumber ]
]

{ #category : #accessing }
PlayerState >> cardsInHand [
	^ cards copy
]

{ #category : #validation }
PlayerState >> checkAvailabilityOf: aCard [
	self
		assert: (cards includes: aCard)
		description: 'That card is not in the hand of the player'
]

{ #category : #accessing }
PlayerState >> lapNumber [
	^ lapNumber copy
]

{ #category : #initialization }
PlayerState >> on: currentPosition and: currentLapNumber and: currentRoundNumber holding: heldCards [
	position := currentPosition copy.
	lapNumber := currentLapNumber copy.
	roundNumber := currentRoundNumber.
	cards := heldCards
]

{ #category : #accessing }
PlayerState >> position [
	^ position copy
]

{ #category : #accessing }
PlayerState >> roundNumber [
	^ roundNumber
]
