"
A class used to create the board spots occupied or not by the players of the game
"
Class {
	#name : #Spot,
	#superclass : #Object,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Spot class >> empty [
	^ EmptySpot newEmpty
]

{ #category : #initialization }
Spot class >> occupiedBy: players [
	| playersToEnterTheSpot |
	"Filter Duplicates"
	playersToEnterTheSpot := OrderedCollection new.
	players
		do: [ :player | playersToEnterTheSpot addIfNotPresent: player ].
	"Check its all symbols"
	playersToEnterTheSpot
		do: [ :player | 
			self
				assert: player isSymbol
				description: 'Spots can only contain players as symbols' ].
	^ OccupiedSpot new occupiedBy: playersToEnterTheSpot
]

{ #category : #accessing }
Spot >> players [ 
	self subclassResponsibility 
]

{ #category : #accessing }
Spot >> quantityOfPlayers [
	self subclassResponsibility
]
