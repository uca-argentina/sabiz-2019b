"
This class generates standard elements with a specific set of characteristics that are going to be needed in order to test each aspect of the model
"
Class {
	#name : #StandardModelTestResource,
	#superclass : #TestResource,
	#category : #'IngSoft2-Tests'
}

{ #category : #boardCreation }
StandardModelTestResource >> effectTestingBoardWithSpots: spotsNumber and: effect at: spotNumber [
	| spots |
	spots := OrderedCollection
		new: spotsNumber
		withAll: (Spot with: NullEffect new).
	spots at: spotNumber put: (Spot with: effect).
	^ self newBoardWithSpotCollection: spots and: 2
]

{ #category : #boardCreation }
StandardModelTestResource >> effectlessBoardWithSpots: spotsNumber andLaps: lapsNumber [
	| spots |
	spots := OrderedCollection
		new: spotsNumber
		withAll: (Spot with: NullEffect new).
	^ self newBoardWithSpotCollection: spots and: lapsNumber
]

{ #category : #boardCreation }
StandardModelTestResource >> newBoardWithSpotCollection: spots and: lapsNumber [
	^ Board new initializeWith: spots andLaps: lapsNumber
]

{ #category : #boardCreation }
StandardModelTestResource >> standardBoard [
	^ Board
		newWith: self standardNumberOfSpots
		and: self standardNumberOfLaps
]

{ #category : #standardValues }
StandardModelTestResource >> standardDeckOfCards [
	| cardTypes |
	cardTypes := OrderedCollection new.
	cardTypes
		addAll: (CardInstantEffect subclasses collect: [ :each | each new ]).
	cardTypes
		addAll: (CardPermanentEffect subclasses collect: [ :each | each new ]).
	^ Deck with: cardTypes asArray
]

{ #category : #gameCreation }
StandardModelTestResource >> standardGame [
	^  Game
		playedBy: self standardSetOfPlayers
		throwing: self standardSetOfDices
		on: self standardBoard
		using: self standardDeckOfCards
]

{ #category : #standardValues }
StandardModelTestResource >> standardNumberOfLaps [
	^ 2
]

{ #category : #standardValues }
StandardModelTestResource >> standardNumberOfSpots [
	^ 10
]

{ #category : #standardValues }
StandardModelTestResource >> standardSetOfDices [
	^ {(RandomDice withFaces: 6)}
]

{ #category : #standardValues }
StandardModelTestResource >> standardSetOfPlayers [
	^ {(Player named: #player1).
	(Player named: #player2).
	(Player named: #player3)}
]
