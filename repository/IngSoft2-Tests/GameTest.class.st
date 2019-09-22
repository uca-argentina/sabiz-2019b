"
This class contains tests about the game
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> negativeNumberOfSpots [
	^ -1
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfPlayers [

	| game player |
	player := Player withNumber: 1.
	game := Game withSpots: 10.
	game addPlayer: player.
	self assert: (game players size == 1) description: 'Game does have correct number of players'
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfSpots [

	| board |
	board := Game withSpots: 20.
	self assert: board numberOfSpots == 20 description: 'Game has incorrect number of spots'
]

{ #category : #tests }
GameTest >> testGameHasGivenPlayer [

	| game player |
	player := Player withNumber: 1.
	game := Game withSpots: 10.
	game addPlayer: player.
	self assert: (game players includes: player) description: 'Game does not include added player'
]

{ #category : #tests }
GameTest >> testGameHasGivenSetOfDices [

	| dices game dice |
	game := Game withSpots: 10.
	dices := OrderedCollection new.
	dice := RandomDice withFaces: 6.
	game addDice: dice.
	dices add: dice.
	dice := LoadedDice loadedWith: 4.
	game addDice: dice.
	dices add: dice.
	self assert: ((game dices includesAll: dices) and: (dices includesAll: game dices)) description: 'Game does not contain given set of dices'
	
]

{ #category : #tests }
GameTest >> testPlayerOneWonTheGame [
]

{ #category : #tests }
GameTest >> testProhibitsCreatingGameWithInvalidNumberOfSpots [
	self
		should: [ Game withSpots: 0 ] raise: Error;
		should: [ Game withSpots: self negativeNumberOfSpots ]
			raise: Error
]

{ #category : #tests }
GameTest >> testRiggedGameEndsAsExpected [
]
