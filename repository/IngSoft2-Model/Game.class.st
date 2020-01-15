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
		'deck',
		'laps',
		'turnAllocator'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Game class >> checkDices: dices [
	self
		assert: dices isNotEmpty
		description: 'Tried to initialize a game with an invalid set of Dices'
]

{ #category : #validation }
Game class >> checkDuplicatePlayers: players [
	self assert: players asSet size = players size description: 'The player set contains a duplicate'
]

{ #category : #validation }
Game class >> checkNumberOfLaps: laps [
	self assert: laps > 0 description: 'Invalid number of laps'
]

{ #category : #validation }
Game class >> checkPlayerQuantity: players [
	self
		assert: players isNotEmpty
		description: 'Not enough players to initialize game'
]

{ #category : #validation }
Game class >> checkPlayersStartWithoutCards: players [
	players do: [ :player | self assert: player cardsInHand isEmpty ]
]

{ #category : #'instance creation' }
Game class >> playedBy: players throwing: dices on: aBoard using: aDeck withLaps: laps [
	self checkDuplicatePlayers: players.
	self checkPlayerQuantity: players.
	self checkDices: dices.
	self checkPlayersStartWithoutCards: players.
	self checkNumberOfLaps: laps.
	^ self new
		playedBy: players
		throwing: dices
		on: aBoard
		using: aDeck
		withLaps: laps
]

{ #category : #cardEffects }
Game >> addEffectOf: aCard [
	globalPermanentCardEffects add: aCard effect
]

{ #category : #spotEffects }
Game >> applyEffectTriggeredBy: player in: newState [
	board applyEffectOn: self triggeredBy: player in: newState
]

{ #category : #accessingPlayer }
Game >> cardsInHandOf: aPlayer [
	^ (self players detect: [ :each | each = aPlayer ]) cardsInHand copy
]

{ #category : #accessingGameState }
Game >> currentRanking [
	^ (self playersCurrentStates
		sort: [ :assoc1 :assoc2 | assoc1 value > assoc2 value ])
		collect: [ :assoc | assoc key ]
]

{ #category : #accessingGame }
Game >> currentTurn [
	^ turnAllocator currentTurn
]

{ #category : #accessingGame }
Game >> deck [
	^ deck copy
]

{ #category : #accessingGame }
Game >> dices [
	^ dices copy
]

{ #category : #accessingGameState }
Game >> finishRanking [
	^ leaderBoard finishRanking
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
	newState := self
		nextStateFor: (self stateOf: player)
		afterMoving: (self totalDisplacementFor: player).
	self updateStateFor: player with: newState.
	self applyEffectTriggeredBy: player in: newState.
	((self playerHasNotFinished: player)
		or: (leaderBoard includes: player))
		ifFalse: [ leaderBoard add: player ]
]

{ #category : #'testing - playing' }
Game >> moveAllPlayers [
	self players do: [ :player | self move: player ]
]

{ #category : #spotEffects }
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
Game >> nextStateFor: aState afterMoving: movementAmount [
	^ board nextStateFor: aState afterMoving: movementAmount
]

{ #category : #'private - playingCards' }
Game >> nextTurnPlaying: aCard affecting: players [
	| currentTurnPlayer |
	currentTurnPlayer := turnAllocator nextTurnWithoutPlayingCards.
	self player: currentTurnPlayer  playsCard: aCard  affecting: players.
	self move: currentTurnPlayer.
	^ currentTurnPlayer
]

{ #category : #'private - playingCards' }
Game >> nextTurnWithoutPlayingCards [
	| currentTurnPlayer |
	currentTurnPlayer := turnAllocator nextTurnWithoutPlayingCards.
	self move: currentTurnPlayer.
	^ currentTurnPlayer
]

{ #category : #accessingGame }
Game >> numberOfLaps [
	^ laps
]

{ #category : #accessingGame }
Game >> numberOfPlayers [
	^ self players size
]

{ #category : #'testing - playing' }
Game >> playAnEntireGame [
	[ self isNotOver ] whileTrue: [ self playOneRound ]
]

{ #category : #'testing - playing' }
Game >> playOneRound [
	self assert: [ self isNotOver ] description: 'Game is already over'.
	self moveAllPlayers
]

{ #category : #playing }
Game >> playTurnFor: player [
	self
		assert: (self playerHasNotFinished: player)
		description: 'Trying to move a player that has already finished'.
	self move: player
]

{ #category : #initialization }
Game >> playedBy: gamePlayers throwing: gameDices on: aBoard using: aDeck withLaps: numberOfLaps [
	leaderBoard := LeaderBoard new.
	board := aBoard copy.
	laps := numberOfLaps.
	deck := aDeck.
	turnAllocator := TurnAllocator for: gamePlayers.
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
		asOrderedDictionary
]

{ #category : #playing }
Game >> player: aPlayer playsCard: aCard affecting: players [
	(self playerHasFinished: aPlayer)
		ifTrue: [ AssertionFailure
				signal: 'Tried to make a player that has already finished play a card' ].
	(self players detect: [ :each | each = aPlayer ])
		playCard: aCard
		on: self
		affecting: players
]

{ #category : #cardEffects }
Game >> player: aPlayer triggersEffectAt: aPosition [
	board player: aPlayer triggersEffectAt: aPosition on: self
]

{ #category : #spotEffects }
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
	^ (self lapOf: player) < self numberOfLaps
]

{ #category : #accessingGame }
Game >> players [
	^ playersStates keys copy
]

{ #category : #accessingGameState }
Game >> playersCurrentStates [
	^ (self players
		collect: [ :player | Association key: player value: (self stateOf: player) ])
		asArray
]

{ #category : #accessingPlayer }
Game >> positionOf: player [
	^ (self stateOf: player) position
]

{ #category : #spotEffects }
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
