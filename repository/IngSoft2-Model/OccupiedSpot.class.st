"
Class that represents a spot with at least one player on it.
"
Class {
	#name : #OccupiedSpot,
	#superclass : #Spot,
	#instVars : [
		'players'
	],
	#classInstVars : [
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OccupiedSpot class >> byPlayers: playersToEnterTheSpot [ 
	players := OrderedCollection new.
	^self new spotOccupiedBy: playersToEnterTheSpot .
]

{ #category : #accessing }
OccupiedSpot >> players [

^ players
]

{ #category : #accessing }
OccupiedSpot >> quantityOfPlayers [
	^ players size
]

{ #category : #initialization }
OccupiedSpot >> spotOccupiedBy: playersToEnterTheSpot [ 
	players := playersToEnterTheSpot 
]
