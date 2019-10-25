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

{ #category : #validation }
Game class >> checkDuplicatePlayers: players [
	self assert: players asSet size = players size
]

{ #category : #validation }
Game class >> checkPlayerQuantity: players checkDices: dices [
	self
		assert: [ players isNotEmpty ]
		description: 'Not enough players to initialize game'.
	self
		assert: [ dices isNotEmpty ]
		description: 'Tried to initialize a game with an invalid set of Dices'
]

{ #category : #'instance creation' }
Game class >> playedBy: players throwing: dices using: aBoard [
	self checkDuplicatePlayers: players.
	self checkPlayerQuantity: players checkDices: dices.
	^ self new players: players dices: dices andBoard: aBoard
]

{ #category : #'instance creation' }
Game class >> standard [
	^ self
		playedBy: self standardSetOfPlayers
		throwing: self standardSetOfDices
		using: Board standard
]

{ #category : #standardValues }
Game class >> standardSetOfDices [
	^ {(RandomDice withFaces: 6)}
]

{ #category : #standardValues }
Game class >> standardSetOfPlayers [
	^ {#player1 . #player2 . #player3}
]

{ #category : #accessing }
Game >> currentPlaces [
	^ state currentPlaces
]

{ #category : #accessing }
Game >> dices [
	^ dices copy
]

{ #category : #accessing }
Game >> includesPlayer: aPlayer [
	^ state includesPlayer: aPlayer
]

{ #category : #playing }
Game >> isNotOver [
	^ self players size > self leaderBoardPositions size
]

{ #category : #accessing }
Game >> lapOfPlayer: player [
	^ state lapOfPlayer: player
]

{ #category : #accessing }
Game >> leaderBoardPositions [
	^ leaderBoard positions
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
Game >> numberOfPlayers [
	^ self players size
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
Game >> winner [
	^ leaderBoard winner
]
