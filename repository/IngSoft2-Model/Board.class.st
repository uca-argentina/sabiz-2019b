"
Class that represents a game board with spots
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spots'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> withSpots: spotsAmmount withPlayers: playersToEnterTheGame [
	self assert: spotsAmmount > 0 description: 'Invalid number of spots'.
	^ self new
		initializeWithSpots: spotsAmmount
		withPlayers: playersToEnterTheGame
]

{ #category : #initialization }
Board >> initializeWithSpots: spotsAmmount withPlayers: playersToEnterTheGame [
	spots := Array new: spotsAmmount withAll: Spot empty.
	spots atWrap: 1 put: (Spot occupiedBy:playersToEnterTheGame )
]

{ #category : #accessing }
Board >> numberOfSpots [
	^ spots size 
]

{ #category : #'private - moving' }
Board >> player: player advances: rollResult [
	| newPosition actualPosition playersAtActualPosition playersAtNewPosition |
	playersAtActualPosition := OrderedCollection new.
	actualPosition := self positionOfPlayer: player.
	newPosition := actualPosition + rollResult.
	newPosition > self numberOfSpots
		ifTrue: [ newPosition := self numberOfSpots ].
	playersAtActualPosition := (spots atWrap: actualPosition) players.
	playersAtNewPosition := (spots atWrap: newPosition) players.
	playersAtActualPosition remove: player.
	playersAtNewPosition add: player.
	playersAtActualPosition isEmpty
		ifTrue: [ spots atWrap: actualPosition put: Spot empty ]
		ifFalse: [ spots
				atWrap: actualPosition
				put: (Spot occupiedBy: playersAtActualPosition) ].
	spots
		atWrap: newPosition
		put: (Spot occupiedBy: playersAtNewPosition)
]

{ #category : #accessing }
Board >> players [
	| players |
	players := OrderedCollection new.
	spots
		do: [ :each | 
			each quantityOfPlayers > 0
				ifTrue: [ players addAll: each players ] ].
	^ players 
]

{ #category : #accessing }
Board >> positionOfPlayer: player [
	spots
		do: [ :eachSpot | 
			(eachSpot players includes: player)
				ifTrue: [ ^ spots indexOf: eachSpot ] ]
]
