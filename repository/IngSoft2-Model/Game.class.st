"
A game with a given number of spots
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'numberOfSpots',
		'dices',
		'players',
		'leaderBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> standard [
	^self withNumberOfSpots: self standardSpotAmount playedBy: self standardSetOfPlayers throwing: self standardSetOfDices
]

{ #category : #standardValues }
Game class >> standardSetOfDices [
	^ {(RandomDice withFaces: 6)}
]

{ #category : #standardValues }
Game class >> standardSetOfPlayers [
	^{ Player withNumber: 1. Player withNumber: 2. Player withNumber: 3 }
]

{ #category : #standardValues }
Game class >> standardSpotAmount [
	^24.
]

{ #category : #'instance creation' }
Game class >> withNumberOfSpots: numberOfSpots playedBy: players throwing: dices [
	| gamePlayers |
	gamePlayers := OrderedCollection new.
	self assert: numberOfSpots > 0 description: 'Invalid number of spots'.
	self
		assert: players isNotEmpty
		description: 'Not enough players to initialize game'.
	self
		assert: dices isNotEmpty
		description: 'Tried to initialize a game with an invalid set of Dices'.
	players
		do:
			[ :each | gamePlayers addIfNotPresent: each ifPresentDo: [ self error: Error ] ].
	^ self new
		initializeWithSpots: numberOfSpots
		players: gamePlayers
		andDices: dices
]

{ #category : #setting }
Game >> addPlayerToLeaderBoard: player [
  
	leaderBoard add: player.
	player reachingTheFinalSpotSetsPlayerFinalPosition: self numberOfSpots
]

{ #category : #accessing }
Game >> dices [

		^dices
]

{ #category : #initialization }
Game >> initializeWithSpots: spotAmount players: gamePlayers andDices: gameDices [
	numberOfSpots := spotAmount.
	players := gamePlayers asOrderedCollection.
	dices := gameDices asOrderedCollection.
	leaderBoard := OrderedCollection new.
]

{ #category : #playing }
Game >> isNotOver [
	^ self players size > self leaderBoard size
]

{ #category : #accessing }
Game >> leaderBoard [
  
	^leaderBoard
]

{ #category : #playing }
Game >> makePlayerMove: player [

	self assert: (player position < self numberOfSpots) description: 'Player already reached the final spot'.
	dices do: [ :dice |
		player advance: dice roll.
	].
	player position >= self numberOfSpots 
		ifTrue: [ self addPlayerToLeaderBoard: player ]
]

{ #category : #accessing }
Game >> numberOfSpots [
  
	^numberOfSpots
]

{ #category : #playing }
Game >> playOneRound [
	self assert: self isNotOver description: 'Game is already over'.
	players
		do: [ :player | 
			player position < self numberOfSpots
				ifTrue: [ self makePlayerMove: player ] ]
]

{ #category : #accessing }
Game >> players [
  
	^ players
]

{ #category : #playing }
Game >> playout [

	"Checks"
	self checkThereAreEnoughPlayersAndDicesToPlay.
	
	"Games"
	[ self isNotOver ]
		whileTrue: [ self playOneRound ]
]

{ #category : #accessing }
Game >> winner [
  
	^ leaderBoard first
]
