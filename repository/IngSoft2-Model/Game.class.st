"
A game with a given number of spots
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'leaderBoard',
		'state',
		'dices',
		'board'
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
	^ self new playedBy: players throwing: dices on: aBoard
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

{ #category : #accessingGameState }
Game >> currentRanking [
	^ state currentRanking
]

{ #category : #accessingGame }
Game >> dices [
	^ dices copy
]

{ #category : #accessingGameState }
Game >> finishRanking [
	^ leaderBoard finishRanking
]

{ #category : #accessingGameState }
Game >> isNotOver [
	^ (leaderBoard includesAll: state players) not
]

{ #category : #accessingGame }
Game >> isPlayedBy: aPlayer [
	^ state isPlayedBy: aPlayer
]

{ #category : #accessingGameState }
Game >> lapOf: player [
	^ state lapOf: player
]

{ #category : #'private - moving' }
Game >> move: player [
	| newState |
	(self playerHasFinished: player)
		ifTrue: [ ^ self ].
	newState := self
		nextStateFor: (state stateOf: player)
		afterMoving: (self totalDisplacementFor: player).
	board applyEffectOn: self triggeredBy: player in: newState.
	((self playerHasNotFinished: player)
		or: (self finishRanking includes: player))
		ifFalse: [ leaderBoard add: player ]
]

{ #category : #'private - moving' }
Game >> moveAllPlayers [
	state players do: [ :player | self move: player ]
]

{ #category : #effect }
Game >> moveEveryoneToTheFirstSpot [
	state players
		do: [ :each | 
			state
				add:
					(PlayerState
						on: 1
						and: (self lapOf: each)
						under: (state stateOf: each) effects)
				for: each ]
]

{ #category : #'private - moving' }
Game >> nextStateFor: aState afterMoving: rollSum [
	^ board nextStateFor: aState afterMoving: rollSum
]

{ #category : #accessingGame }
Game >> numberOfPlayers [
	^ state players size
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

{ #category : #initialization }
Game >> playedBy: gamePlayers throwing: gameDices on: aBoard [
	leaderBoard := LeaderBoard new.
	board := aBoard.
	dices := gameDices.
	state := GameState playedBy: gamePlayers
]

{ #category : #effect }
Game >> player: player triggersMoonWalkEffectMoving: anAmount [
	state players
		do: [ :each | 
			| newState |
			each == player
				ifFalse: [ newState := board
						nextStateFor: (state stateOf: each)
						afterMoving: anAmount.
					state add: newState for: each ] ]
]

{ #category : #accessingGameState }
Game >> playerHasFinished: player [
	^ (self playerHasNotFinished: player) not
]

{ #category : #accessingGameState }
Game >> playerHasNotFinished: player [
	^ (self lapOf: player) < board numberOfLaps
]

{ #category : #accessingGameState }
Game >> positionOf: aPlayer [
	^ state positionOf: aPlayer
]

{ #category : #effect }
Game >> rewindPositionFor: player [
	| playerStates |
	playerStates := state historyOf: player.
	playerStates size <= 1
		ifTrue: [ playerStates
				add: (PlayerState on: 1 and: 0 under: (state stateOf: player) effects) ]
		ifFalse: [ | previousState |
			previousState := playerStates at: playerStates size - 1.
			playerStates
				add:
					(PlayerState
						on: previousState position
						and: previousState lapNumber
						under: (state stateOf: player) effects) ]
]

{ #category : #'private - moving' }
Game >> rollSum [
	^ dices inject: 0 into: [ :sum :dice | sum + dice roll ]
]

{ #category : #'private - moving' }
Game >> set: aState for: player [
	state add: aState for: player
]

{ #category : #'private - moving' }
Game >> totalDisplacementFor: player [
	| total |
	total := state globalPlayerEffects
		inject: self rollSum
		into: [ :sum :each | sum + each value ].
	total := (state stateOf: player) effects
		inject: total
		into: [ :sum :each | sum + each value ].
	^ total
]

{ #category : #accessingGameState }
Game >> winner [
	^ leaderBoard winner
]
