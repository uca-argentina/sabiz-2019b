"
A game with a given number of spots
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dices',
		'leaderBoard',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> standard [
	^ self
		withNumberOfSpots: self standardSpotAmount
		playedBy: self standardSetOfPlayers
		throwing: self standardSetOfDices
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
Game class >> withNumberOfSpots: numberOfSpots playedBy: players throwing: dices [
	| gamePlayers |
	players asOrderedCollection.
	gamePlayers := OrderedCollection new.
	players do: [ :each | gamePlayers addIfNotPresent: each ].
	self
		assert: gamePlayers isNotEmpty
		description: 'Not enough players to initialize game'.
	self
		assert: dices isNotEmpty
		description: 'Tried to initialize a game with an invalid set of Dices'.
	self
		assert: players size = gamePlayers size
		description: 'Tried to initialize game with a duplicated player'.
	^ self new
		initializeWithSpots: numberOfSpots
		players: gamePlayers
		andDices: dices
]

{ #category : #private }
Game >> addPlayerToLeaderBoard: player [
	leaderBoard add: player
]

{ #category : #accessing }
Game >> board [
	^ board copy
]

{ #category : #accessing }
Game >> dices [
	^ dices copy
]

{ #category : #initialization }
Game >> initializeWithSpots: spotAmount players: gamePlayers andDices: gameDices [
	dices := gameDices asOrderedCollection.
	leaderBoard := OrderedCollection new.
	board := Board withSpots: spotAmount withPlayers: gamePlayers
]

{ #category : #playing }
Game >> isNotOver [
	^ self players size > self leaderBoard size
]

{ #category : #accessing }
Game >> leaderBoard [
	^ leaderBoard copy
]

{ #category : #private }
Game >> movePlayer: player [
	self
		assert: (board positionOfPlayer: player) < self numberOfSpots
		description: 'Player already reached the final spot'.
	dices do: [ :dice | board player: player advances: dice roll ].
	(board positionOfPlayer: player) >= self numberOfSpots
		ifTrue: [ self addPlayerToLeaderBoard: player ]
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
	self assert: self isNotOver description: 'Game is already over'.
	self players
		do: [ :player | 
			(board positionOfPlayer: player) < self numberOfSpots
				ifTrue: [ self movePlayer: player ] ]
]

{ #category : #accessing }
Game >> players [
	^ board players
]

{ #category : #accessing }
Game >> winner [
	self
		assert: leaderBoard isNotEmpty
		description: 'No one has reached the end yet'.
	^ leaderBoard first
]
