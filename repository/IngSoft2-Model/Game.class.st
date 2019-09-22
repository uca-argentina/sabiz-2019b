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
	
	| standardGame |
	standardGame := self new initializeWith: self standardSpotAmount.
	standardGame addDice: self standardDice.
	^standardGame.
]

{ #category : #standardValues }
Game class >> standardDice [

	^RandomDice withFaces: 6.
]

{ #category : #standardValues }
Game class >> standardSpotAmount [
	^24.
]

{ #category : #'instance creation' }
Game class >> withSpots: numberOfSpots [
  
	self assert: numberOfSpots > 0 description: 'Number of spots invalid'.
	^self new initializeWith: numberOfSpots
]

{ #category : #setting }
Game >> addDice: dice [
			
	dices add: dice.
]

{ #category : #setting }
Game >> addPlayer: player [

	players do: [ :each |
		self assert: each identificationNumber ~= player identificationNumber description: 'A player with that ID is already in the game'.
	].
	players add: player
]

{ #category : #setting }
Game >> addPlayerToLeaderBoard: player [
  
	leaderBoard add: player.
	player reachingTheFinalSpotSetsPlayerFinalPosition: self numberOfSpots
]

{ #category : #playing }
Game >> checkThereAreEnoughPlayersAndDicesToPlay [
	self
		assert: players isNotEmpty
		description: 'Game cannot start without any players'.	
	self
		assert: dices isNotEmpty
		description: 'Game cannot start without dice/s'
]

{ #category : #accessing }
Game >> dices [

		^dices
]

{ #category : #initialization }
Game >> initializeWith: spotAmount [
  
	numberOfSpots := spotAmount.
	players := OrderedCollection new.
	dices := OrderedCollection new.
	leaderBoard := OrderedCollection new.
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

	self checkThereAreEnoughPlayersAndDicesToPlay.
	
	self assert: players size > (self leaderBoard size) description: 'Game is already over'.
	players do: [ :player |
		( player position < self numberOfSpots ) ifTrue: [ self makePlayerMove: player. ].
	].
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
	self checkThereAreEnoughPlayersAndDicesToPlay.
	[ players size > self leaderBoard size ]
		whileTrue: [ self playOneRound ]
]

{ #category : #accessing }
Game >> theWinnerIs [
  
	^ leaderBoard first
]
