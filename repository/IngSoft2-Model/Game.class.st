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

{ #category : #'instance creation' }
Game class >> standard [
	^ self
		withNumberOfSpots: self standardSpotAmount
		playedBy: self standardSetOfPlayers
		throwing: self standardSetOfDices
		withLapsToComplete: self standardLapAmmount
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

{ #category : #'instance creation' }
Game class >> withNumberOfSpots: numberOfSpots playedBy: players throwing: dices withLapsToComplete: numberOfLaps [
	| gamePlayers |
	players asOrderedCollection.
	gamePlayers := OrderedCollection new.
	players do: [ :each | gamePlayers addIfNotPresent: each ].
	self
		assert: [ gamePlayers isNotEmpty ]
		description: 'Not enough players to initialize game'.
	self
		assert: [ dices isNotEmpty ]
		description: 'Tried to initialize a game with an invalid set of Dices'.
	self
		assert: [ players size = gamePlayers size ]
		description: 'Tried to initialize game with a duplicated player'.
	^ self new
		initializeWithSpots: numberOfSpots
		players: gamePlayers
		andDices: dices
		andLaps: numberOfLaps
]

{ #category : #accessing }
Game >> dices [
	^ dices copy
]

{ #category : #testing }
Game >> includesPlayer: aPlayer [
	^ state includesPlayer: aPlayer
]

{ #category : #initialization }
Game >> initializeWithSpots: spotAmount players: gamePlayers andDices: gameDices andLaps: numberOfLaps [
	dices := gameDices asOrderedCollection.
	leaderBoard := LeaderBoard initialize.
	board := Board withSpots: spotAmount andNumberOfLaps: numberOfLaps.
	state := GameState
		newGamePlayedBy: gamePlayers
		onBoard: board
		throwing: dices
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

{ #category : #'private - moving' }
Game >> movePlayer: player [
	| diceSum |
	diceSum := 0.
	self
		assert: [ (state positionOfPlayer: player) < self numberOfSpots ]
		description: 'Player already reached the final spot'.
	dices do: [ :dice | diceSum := diceSum + dice roll ].
	state player: player advances: diceSum.
	(state positionOfPlayer: player) >= self numberOfSpots
		ifTrue: [ leaderBoard add: player ]
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
	self players
		do: [ :player | 
			(self playerHasNotFinished: player)
				ifTrue: [ self movePlayer: player ] ]
]

{ #category : #playing }
Game >> playerHasNotFinished: player [
	^ (state positionOfPlayer: player) < self numberOfSpots
]

{ #category : #accessing }
Game >> players [
	^ state players
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
