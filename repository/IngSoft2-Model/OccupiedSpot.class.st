"
Class that represents a spot with at least one player on it.
"
Class {
	#name : #OccupiedSpot,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OccupiedSpot >> occupiedBy: playersToEnterTheSpot [
	players := playersToEnterTheSpot
]

{ #category : #accessing }
OccupiedSpot >> players [
	^ players copy
]

{ #category : #accessing }
OccupiedSpot >> quantityOfPlayers [
	^ players size
]
