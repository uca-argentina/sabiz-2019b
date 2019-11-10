"
Tests for Turn and Turn class
"
Class {
	#name : #TurnTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TurnTest >> testCantKnowTheTurnIfTheGameJustStartedBeforeCallNextTurn [
	| game |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(RandomDice withFaces: 6)}
		using: (Board regularWithSpots: 10 andLaps: 2).
	self should: [ game currentTurn ] raise: AssertionFailure
]

{ #category : #tests }
TurnTest >> testItsThePreviousPlayerTurnUntilCallingNextTurn [
	| game |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(RandomDice withFaces: 6)}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game nextTurn.
	self assert: [(Player named: #player1) = game currentTurn].
]

{ #category : #tests }
TurnTest >> testTurnsFollowOrderOfInsertionOfPlayersInTheGame [
	| game |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(RandomDice withFaces: 6)}
		using: (Board regularWithSpots: 10 andLaps: 2).
	self assert: (Player named: #player1) equals: game nextTurn.
	self assert: (Player named: #player2) equals: game nextTurn.
	self assert: (Player named: #player1) equals: game nextTurn
]
