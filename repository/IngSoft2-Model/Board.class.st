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

{ #category : #'instance creation' }
Board class >> withSpots: spotsAmmount withPlayers: playersToEnterTheGame [
	self assert: spotsAmmount > 0 description: 'Invalid number of spots'.
	^ self new
		initializeWithSpots: spotsAmmount
		withPlayers: playersToEnterTheGame
]

{ #category : #testing }
Board >> includesPlayer: aPlayer [
	^ self players includes: aPlayer
]

{ #category : #initialization }
Board >> initializeWithSpots: spotsAmmount withPlayers: playersToEnterTheGame [
	spots := Array new: spotsAmmount withAll: Spot empty.
	spots at: 1 put: (Spot occupiedBy: playersToEnterTheGame)
]

{ #category : #accessing }
Board >> numberOfSpots [
	^ spots size
]

{ #category : #'private - moving' }
Board >> player: player advances: rollResult [
	| newPosition actualPosition |
	actualPosition := self positionOfPlayer: player.
	newPosition := actualPosition + rollResult.
	newPosition := self numberOfSpots min: newPosition.
	self player: player movesFromSpotAt: actualPosition to: newPosition
]

{ #category : #'private - moving' }
Board >> player: player entersSpotAt: newPosition [
	| playersAtNewPosition |
	playersAtNewPosition := (spots at: newPosition) players.
	playersAtNewPosition add: player.
	spots at: newPosition put: (Spot occupiedBy: playersAtNewPosition)
]

{ #category : #'private - moving' }
Board >> player: player leavesSpotAt: actualPosition [
	| playersAtActualPosition |
	playersAtActualPosition := (spots at: actualPosition) players.
	playersAtActualPosition remove: player.
	playersAtActualPosition isEmpty
		ifTrue: [ spots at: actualPosition put: Spot empty ]
		ifFalse: [ spots
				at: actualPosition
				put: (Spot occupiedBy: playersAtActualPosition) ].
]

{ #category : #'private - moving' }
Board >> player: player movesFromSpotAt: actualPosition to: newPosition [
	self player: player leavesSpotAt: actualPosition.
	self player: player entersSpotAt: newPosition
]

{ #category : #accessing }
Board >> players [
	^ spots
		inject: OrderedCollection new
		into: [ :result :eachSpot | 
			result
				addAll: eachSpot players;
				yourself ]
]

{ #category : #accessing }
Board >> positionOfPlayer: player [
	self
		assert: (self includesPlayer: player)
		description: 'That player is not in the game'.
	spots
		do: [ :eachSpot | 
			(eachSpot players includes: player)
				ifTrue: [ ^ spots indexOf: eachSpot ] ]
]
