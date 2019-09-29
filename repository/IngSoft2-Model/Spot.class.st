"
A class used to create the board spots occupied or not by the players of the game
"
Class {
	#name : #Spot,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Spot class >> empty [ 
	^ EmptySpot new.
]

{ #category : #initialization }
Spot class >> occupiedBy: players [
	| playersToEnterTheSpot |
	playersToEnterTheSpot  := OrderedCollection new.
	players do: [ :player | playersToEnterTheSpot  addIfNotPresent: player ].
	^ OccupiedSpot byPlayers: playersToEnterTheSpot 
]

{ #category : #accessing }
Spot >> quantityOfPlayers [
	self subclassResponsibility
]
