"
Class that represents a spot with no players.
"
Class {
	#name : #EmptySpot,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
EmptySpot class >> newEmpty [
	^ EmptySpot new emptySpot
]

{ #category : #initialization }
EmptySpot class >> newEmptySpot [
	self shouldBeImplemented.
]

{ #category : #initialization }
EmptySpot >> emptySpot [
	players := OrderedCollection new.
]

{ #category : #accessing }
EmptySpot >> players [
	^ OrderedCollection new.
]

{ #category : #accessing }
EmptySpot >> quantityOfPlayers [
	^ 0
]
