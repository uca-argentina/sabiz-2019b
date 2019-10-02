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

{ #category : #'instance creation' }
Spot class >> empty [
	^ self new emptySpot
]

{ #category : #'instance creation' }
Spot class >> occupiedBy: players [
	| playersToEnterTheSpot |
	playersToEnterTheSpot := OrderedCollection new.
	players
		do: [ :player | playersToEnterTheSpot addIfNotPresent: player ].
	^ self new occupiedBy: playersToEnterTheSpot
]

{ #category : #initialization }
Spot >> emptySpot [
	players := OrderedCollection new
]

{ #category : #initialization }
Spot >> occupiedBy: playersToEnterTheSpot [
	players := playersToEnterTheSpot
]

{ #category : #accessing }
Spot >> players [
	^ players copy
]

{ #category : #accessing }
Spot >> quantityOfPlayers [
	^ players size
]
