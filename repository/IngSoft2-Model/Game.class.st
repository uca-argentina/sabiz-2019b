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
		'playedCards',
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

{ #category : #'instance creation' }
Game class >> playedBy: players throwing: dices on: aBoard using: aDeck withLaps: laps [
	self checkDuplicatePlayers: players.
	self checkPlayerQuantity: players.
	self checkDices: dices.
	self checkNumberOfLaps: laps.
	^ self new
		playedBy: players
		throwing: dices
		on: aBoard
		using: aDeck
		withLaps: laps
]

{ #category : #accessingPlayer }
Game >> cardsInHandOf: player [
	^ (self stateOf: player) cardsInHand
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

{ #category : #'private - spotEffects' }
Game >> dealCardTo: player [
	| current newState hand |
	current := self stateOf: player.
	hand := current cardsInHand.
	hand add: deck nextCard.
	newState := PlayerState
		on: current position
		and: current lapNumber
		and: current roundNumber
		under: current effects
		holding: hand.
	self updateStateFor: player with: newState
]

{ #category : #accessingGame }
Game >> deck [
	^ deck copy
]

{ #category : #accessingGame }
Game >> dices [
	^ dices copy
]

{ #category : #'private - spotEffects' }
Game >> displace: player by: anAmount [
	| newState |
	newState := board
		nextStateFor: (self stateOf: player)
		afterMoving: anAmount
		onRoundNumber: turnAllocator currentRoundNumber.
	self updateStateFor: player with: newState
]

{ #category : #'private - cardEffects' }
Game >> effectsOn: player [
	| cardsTargetingPlayer |
	cardsTargetingPlayer := (playedCards
		select: [ :each | {player} = each target ])
		collect: [ :each | each effect value ].
	cardsTargetingPlayer isNotEmpty
		ifTrue: [ ^ cardsTargetingPlayer sum ].
	^ 0
]

{ #category : #accessingGameState }
Game >> finishRanking [
	^ leaderBoard finishRanking
]

{ #category : #'private - cardEffects' }
Game >> globalPermanentCardEffects [
	| globalCards |
	globalCards := (playedCards
		select: [ :each | self players asArray = each target ])
		collect: [ :each | each effect value ].
	globalCards isNotEmpty
		ifTrue: [ ^ globalCards sum ].
	^ 0
]

{ #category : #accessingPlayer }
Game >> historyOf: player [
	^ (playersStates at: player) copy
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
	newState := board
		nextStateFor: (self stateOf: player)
		afterMoving: (self totalDisplacementFor: player)
		onRoundNumber: turnAllocator currentRoundNumber.
	self updateStateFor: player with: newState.
	board applyEffectOn: self triggeredBy: player in: newState.
	((self playerHasNotFinished: player)
		or: (leaderBoard includes: player))
		ifFalse: [ leaderBoard add: player ]
]

{ #category : #'testing - playing' }
Game >> moveAllPlayers [
	self players do: [ :player | self move: player ]
]

{ #category : #'private - spotEffects' }
Game >> moveEveryoneToTheFirstSpot [
	self players
		do: [ :each | 
			self
				updateStateFor: each
				with:
					(PlayerState
						on: 1
						and: (self lapOf: each)
						and: turnAllocator currentRoundNumber
						under: (self stateOf: each) effects
						holding: (self stateOf: each) cardsInHand) ]
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
	self
		assert: turnAllocator currentTurn = player
		description: 'Trying to move a player out of turn'.
	self
		updateStateFor: player
		with:
			(PlayerState
				on: (self stateOf: player) position
				and: (self stateOf: player) lapNumber
				and: turnAllocator currentRoundNumber
				under: (self stateOf: player) effects
				holding: (self stateOf: player) cardsInHand).
	self move: player.
	(self playerHasFinished: player)
		ifTrue: [ turnAllocator playerHasFinished: player ].
	self isNotOver
		ifTrue: [ turnAllocator advanceTurnWheel ]
]

{ #category : #initialization }
Game >> playedBy: gamePlayers throwing: gameDices on: aBoard using: aDeck withLaps: numberOfLaps [
	leaderBoard := LeaderBoard new.
	board := aBoard copy.
	laps := numberOfLaps.
	deck := aDeck.
	turnAllocator := TurnAllocator for: gamePlayers.
	dices := gameDices copy.
	playedCards := OrderedCollection new.
	playersStates := (gamePlayers
		collect: [ :each | 
			Association
				key: each
				value:
					{(PlayerState
						on: 1
						and: 0
						holding: {deck nextCard. deck nextCard})
				} asOrderedCollection ]) asOrderedDictionary
]

{ #category : #'private - spotEffects' }
Game >> player: player triggersMoonWalkEffectMoving: anAmount [
	self players
		do: [ :each | 
			| newState |
			each == player
				ifFalse: [ newState := board
						nextStateFor: (self stateOf: each)
						afterMoving: anAmount
						onRoundNumber: turnAllocator currentRoundNumber.
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

{ #category : #'private - spotEffects' }
Game >> rewindPositionFor: player [
	| targetState |
	targetState := ((self historyOf: player)
		select: [ :each | each roundNumber = (turnAllocator currentRoundNumber - 1) ])
		first.
	self
		updateStateFor: player
		with:
			(PlayerState
				on: targetState position
				and: targetState lapNumber
				and: turnAllocator currentRoundNumber
				under: targetState effects
				holding: targetState cardsInHand)
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
				signal: 'Asked for a player that is not in the game' ]) last copy
]

{ #category : #'private - moving' }
Game >> totalDisplacementFor: player [
	^ self globalPermanentCardEffects + self rollSum
		+ (self effectsOn: player)
]

{ #category : #'private - updating' }
Game >> updateStateFor: player with: aState [
	| playerStates |
	playerStates := playersStates at: player.
	playerStates add: aState
]

{ #category : #accessingGameState }
Game >> winner [
	^ leaderBoard winner
]
