"
Class that represents a spot with no players.
"
Class {
	#name : #EmptySpot,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
EmptySpot >> players [
	^ OrderedCollection new.
]

{ #category : #accessing }
EmptySpot >> quantityOfPlayers [
	^ 0
]
