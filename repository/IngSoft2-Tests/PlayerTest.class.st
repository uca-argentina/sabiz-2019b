Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> negativeNumbers [
	^ -1
]

{ #category : #tests }
PlayerTest >> testPlayerAdvancesWhenDiceIsRolled [

	| dice player |
	dice := LoadedDice loadedWith: 4.
	player := Player withNumber: 1.
	player advance: (dice roll).
	self assert: player position equals: 5 
]

{ #category : #tests }
PlayerTest >> testPlayerHasWon [
	| dice player game |
	game := Game withSpots: 10.
	dice := LoadedDice loadedWith: 10.
	player := Player withNumber: 1.
	game addPlayer: player.
	game makeMoveByPlayer: player advancing: dice roll.
	self assert: (game leaderBoard first) == player 
]

{ #category : #tests }
PlayerTest >> testPlayerStartsAtPositionOne [
	| player |
	player := Player withNumber: 1.
	self assert: player position equals: 1.
]

{ #category : #tests }
PlayerTest >> testProhibitsCreatingPlayerWithWrongIdentificationNumber [
	self
		should: [ Player withNumber: 0 ] raise: Error;
		should: [ Game withSpots: self negativeNumbers ] raise: Error
]
