"
A game with a given number of spots
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dices',
		'leaderBoard',
		'board',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Game class >> addIgnoringRepeated: players [
	| gamePlayers |
	players asOrderedCollection.
	gamePlayers := OrderedCollection new.
	players do: [ :each | gamePlayers addIfNotPresent: each ].
	^ gamePlayers
]

{ #category : #testing }
Game class >> checkPlayers: gamePlayers checkDices: dices checkRepeatedPlayers: players [
	self
		assert: [ gamePlayers isNotEmpty ]
		description: 'Not enough players to initialize game'.
	self
		assert: [ dices isNotEmpty ]
		description: 'Tried to initialize a game with an invalid set of Dices'.
	self
		assert: [ players size = gamePlayers size ]
		description: 'Tried to initialize game with a duplicated player'
]

{ #category : #'instance creation' }
Game class >> playedBy: players throwing: dices using: aBoard [
	| gamePlayers |
	gamePlayers := self addIgnoringRepeated: players.
	self
		checkPlayers: gamePlayers
		checkDices: dices
		checkRepeatedPlayers: players.
	^ self new players: gamePlayers dices: dices andBoard: aBoard
]

{ #category : #'instance creation' }
Game class >> standard [
	^ self
		playedBy: self standardSetOfPlayers
		throwing: self standardSetOfDices
		using:
			(Board
				standardWithSpots: self standardSpotAmount
				andNumberOfLaps: self standardLapAmmount)
]

{ #category : #standardValues }
Game class >> standardLapAmmount [
	^ 3
]

{ #category : #standardValues }
Game class >> standardSetOfDices [
	^ {(RandomDice withFaces: 6)}
]

{ #category : #standardValues }
Game class >> standardSetOfPlayers [
	^ {#player1 . #player2 . #player3}
]

{ #category : #standardValues }
Game class >> standardSpotAmount [
	^ 24
]

{ #category : #accessing }
Game >> currentPlaces [
	^ state currentPlaces
]

{ #category : #accessing }
Game >> dices [
	^ dices copy
]

{ #category : #testing }
Game >> includesPlayer: aPlayer [
	^ state includesPlayer: aPlayer
]

{ #category : #playing }
Game >> isNotOver [
	^ self players size > self leaderBoard size
]

{ #category : #accessing }
Game >> lapOfPlayer: player [
	^ state lapOfPlayer: player
]

{ #category : #accessing }
Game >> leaderBoard [
	^ leaderBoard copy
]

{ #category : #playing }
Game >> moveAllPlayers [
	self players do: [ :player | self movePlayer: player ]
]

{ #category : #'private - moving' }
Game >> movePlayer: player [
	| diceSum |
	diceSum := 0.
	dices do: [ :dice | diceSum := diceSum + dice roll ].
	state player: player advances: diceSum.
	(self playerHasNotFinished: player)
		ifTrue: [ state
				player: player
				triggersEffectAtPosition: (self positionOfPlayer: player).
			(self playerHasNotFinished: player)
				ifFalse: [ leaderBoard add: player ] ]
		ifFalse: [ leaderBoard add: player ]
]

{ #category : #accessing }
Game >> numberOfLaps [
	^ board numberOfLaps
]

{ #category : #accessing }
Game >> numberOfSpots [
	^ board numberOfSpots
]

{ #category : #playing }
Game >> playAnEntireGame [
	[ self isNotOver ] whileTrue: [ self playOneRound ]
]

{ #category : #playing }
Game >> playOneRound [
	self assert: [ self isNotOver ] description: 'Game is already over'.
	self moveAllPlayers
]

{ #category : #playing }
Game >> playerHasNotFinished: player [
	^ (state lapOfPlayer: player) < self numberOfLaps
]

{ #category : #accessing }
Game >> players [
	^ state players
]

{ #category : #initialization }
Game >> players: gamePlayers dices: gameDices andBoard: aBoard [
	dices := gameDices asOrderedCollection.
	leaderBoard := LeaderBoard new.
	board := aBoard.
	state := GameState
		newGamePlayedBy: gamePlayers
		onBoard: board copy
		throwing: dices
]

{ #category : #accessing }
Game >> positionOfPlayer: aPlayer [
	^ state positionOfPlayer: aPlayer
]

{ #category : #accessing }
Game >> quantityOfPlayers [
	^ self players size
]

{ #category : #accessing }
Game >> winner [
	self
		assert: [ leaderBoard isNotEmpty ]
		description: 'No one has reached the end yet'.
	^ leaderBoard first
]
