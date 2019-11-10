"
A game
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'leaderBoard',
		'dices',
		'board',
		'playersStates',
		'globalPermanentCardEffects',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Game class >> checkDuplicatePlayers: players [
	| playersNames |
	playersNames := players collect: [ :each | each name ].
	self assert: playersNames asSet size = players size
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
Game class >> playedBy: players throwing: dices using: aBoard andDeckLoadedWith: anEffect [
	self checkDuplicatePlayers: players.
	self checkPlayerQuantity: players checkDices: dices.
	^ self new
		playedBy: players
		throwing: dices
		on: aBoard
		usingDeckLoadedWith: anEffect
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
	^ {(Player named: #player1).
	(Player named: #player2).
	(Player named: #player3)}
]

{ #category : #accessingGameState }
Game >> currentRanking [
	^ (self playersCurrentStates
		sort: [ :assoc1 :assoc2 | assoc1 value > assoc2 value ])
		collect: [ :assoc | assoc key ]
]

{ #category : #accessingGame }
Game >> dices [
	^ dices copy
]

{ #category : #accessingGameState }
Game >> finishRanking [
	^ leaderBoard finishRanking
]

{ #category : #playing }
Game >> giveCardTo: aPlayer [

]

{ #category : #accessingPlayer }
Game >> historyOf: player [
	^ playersStates at: player
]

{ #category : #accessingGameState }
Game >> isNotOver [
	^ (leaderBoard includesAll: self players) not
]

{ #category : #accessingGame }
Game >> isPlayedBy: player [
	^ self players includes: player
]

{ #category : #accessingPlayer }
Game >> lapOf: player [
	^ (self stateOf: player) lapNumber
]

{ #category : #'private - moving' }
Game >> move: player [
	| newState |
	(self playerHasFinished: player)
		ifTrue: [ ^ self ].
	newState := self
		nextStateFor: (self stateOf: player)
		afterMoving: (self totalDisplacementFor: player).
	self updateStateFor: player with: newState.
	board applyEffectOn: self triggeredBy: player in: newState.
	((self playerHasNotFinished: player)
		or: (leaderBoard includes: player))
		ifFalse: [ leaderBoard add: player ]
]

{ #category : #'private - moving' }
Game >> moveAllPlayers [
	self players do: [ :player | self move: player ]
]

{ #category : #effect }
Game >> moveEveryoneToTheFirstSpot [
	self players
		do: [ :each | 
			self
				updateStateFor: each
				with:
					(PlayerState
						on: 1
						and: (self lapOf: each)
						under: (self stateOf: each) effects) ]
]

{ #category : #'private - moving' }
Game >> nextStateFor: aState afterMoving: rollSum [
	^ board nextStateFor: aState afterMoving: rollSum
]

{ #category : #accessingGame }
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

{ #category : #initialization }
Game >> playedBy: gamePlayers throwing: gameDices on: aBoard [
	leaderBoard := LeaderBoard new.
	board := aBoard copy.
	deck := Deck newStandard.
	dices := gameDices copy.
	globalPermanentCardEffects := OrderedCollection new.
	gamePlayers
		do: [ :each | 
			each cardsInHand add: deck nextCard.
			each cardsInHand add: deck nextCard ].
	playersStates := (gamePlayers
		collect: [ :each | 
			Association
				key: each
				value: {(PlayerState on: 1 and: 0)} asOrderedCollection ])
		asDictionary
]

{ #category : #initialization }
Game >> playedBy: gamePlayers throwing: gameDices on: aBoard usingDeckLoadedWith: anEffect [
	leaderBoard := LeaderBoard new.
	board := aBoard copy.
	deck := Deck newLoadedWith: anEffect.
	dices := gameDices copy.
	globalPermanentCardEffects := OrderedCollection new.
	playersStates := (gamePlayers
		collect: [ :each | 
			Association
				key: each
				value: {(PlayerState on: 1 and: 0)} asOrderedCollection ])
		asDictionary
]

{ #category : #effect }
Game >> player: player triggersMoonWalkEffectMoving: anAmount [
	self players
		do: [ :each | 
			| newState |
			each == player
				ifFalse: [ newState := board
						nextStateFor: (self stateOf: each)
						afterMoving: anAmount.
					self updateStateFor: each with: newState ] ]
]

{ #category : #accessingGameState }
Game >> playerHasFinished: player [
	^ (self playerHasNotFinished: player) not
]

{ #category : #accessingGameState }
Game >> playerHasNotFinished: player [
	^ (self lapOf: player) < board numberOfLaps
]

{ #category : #accessingPlayer }
Game >> playerNumber: anInteger [
	^ self players at: anInteger
]

{ #category : #accessingPlayer }
Game >> players [
	^ playersStates keys copy
]

{ #category : #accessingPlayer }
Game >> playersCurrentStates [
	^ (self players
		collect: [ :player | Association key: player value: (self stateOf: player) ])
		asArray
]

{ #category : #accessingPlayer }
Game >> positionOf: player [
	^ (self stateOf: player) position
]

{ #category : #effect }
Game >> rewindPositionFor: player [
	| history |
	history := self historyOf: player.
	history size <= 2
		ifTrue: [ self
				updateStateFor: player
				with: (PlayerState on: 1 and: 0 under: (self stateOf: player) effects) ]
		ifFalse: [ | previousState |
			previousState := history at: history size - 3.
			self
				updateStateFor: player
				with:
					(PlayerState
						on: previousState position
						and: previousState lapNumber
						under: (self stateOf: player) effects) ]
]

{ #category : #'private - moving' }
Game >> rollSum [
	^ dices inject: 0 into: [ :sum :dice | sum + dice roll ]
]

{ #category : #accessingPlayer }
Game >> stateOf: player [
	^ (playersStates
		at: player
		ifAbsent: [ AssertionFailure
				signal: 'Asked for a player that is not in the game' ]) last
]

{ #category : #'private - moving' }
Game >> totalDisplacementFor: player [
	| total |
	total := globalPermanentCardEffects
		inject: self rollSum
		into: [ :sum :each | sum + each value ].
	total := (self stateOf: player) effects
		inject: total
		into: [ :sum :each | sum + each value ].
	^ total
]

{ #category : #updating }
Game >> updateStateFor: player with: aState [
	| playerStates |
	playerStates := playersStates at: player.
	playerStates add: aState
]

{ #category : #accessingGameState }
Game >> winner [
	^ leaderBoard winner
]
