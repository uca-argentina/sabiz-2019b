"
This class contains tests about boards
"
Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'additional methods' }
BoardTest >> distributionCounter [
	| distributionCounter |
	distributionCounter := Dictionary new.
	Spot idealDistribution
		keysDo: [ :each | distributionCounter at: each put: 0 ].
	^ distributionCounter
]

{ #category : #tests }
BoardTest >> testCreatingACustomBoardRequiresCollectionOfSpotsToUse [
	self
		should: [ Board withSpotsCollection: {} andNumberOfLaps: 5 ]
		raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testCustomBoardHasParticularEffectAtGivenPosition [
	| board |
	board := Board
		withSpotsCollection:
			{Empty new.
			MoonWalk new.
			WormHole new.
			TimeMachine new.
			SpeedUp new.
			AtomicBomb new}
		andNumberOfLaps: 5.
	self assert: (board spotAt: 1) className asSymbol == #Empty.
	self assert: (board spotAt: 2) className asSymbol == #MoonWalk.
	self assert: (board spotAt: 3) className asSymbol == #WormHole.
	self assert: (board spotAt: 4) className asSymbol == #TimeMachine.
	self assert: (board spotAt: 5) className asSymbol == #SpeedUp.
	self assert: (board spotAt: 6) className asSymbol == #AtomicBomb
]

{ #category : #tests }
BoardTest >> testEmptyBoardHasNoSpecialSpots [
	| board |
	board := Board
		withSpotsCollection:
			{Empty new.
			Empty new.
			Empty new.
			Empty new}
		andNumberOfLaps: 5.
	board spots
		do: [ :each | self assert: [ each className asSymbol = #Empty ] ]
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfLaps [
	self
		should: [ Board standardWithSpots: 10 andNumberOfLaps: 0 ]
			raise: AssertionFailure;
		should: [ Board standardWithSpots: 10 andNumberOfLaps: -1 ]
			raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ Board standardWithSpots: 0 andNumberOfLaps: 2 ]
			raise: AssertionFailure;
		should: [ Board standardWithSpots: -1 andNumberOfLaps: 2 ]
			raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testStandardBoardHasExpectedSpotDistribution [
	| board distributionCounter |
	distributionCounter := self distributionCounter.
	board := Board standardWithSpots: 100000 andNumberOfLaps: 1.
	board spots
		do: [ :each | 
			distributionCounter
				at: each className asSymbol
				put: (distributionCounter at: each className asSymbol) + 1 ].
	self
		assert: [ (distributionCounter collect: [ :each | each / 1000 roundTo: 1 ])
				= Spot idealDistribution ]
]
