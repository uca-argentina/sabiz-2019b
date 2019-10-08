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
	distributionCounter at: #AtomicBomb put: 0.
	distributionCounter at: #Empty put: 0.
	distributionCounter at: #MoonWalk put: 0.
	distributionCounter at: #SpeedUp put: 0.
	distributionCounter at: #TimeMachine put: 0.
	distributionCounter at: #WormHole put: 0.
	^ distributionCounter
]

{ #category : #'additional methods' }
BoardTest >> idealDistribution [
	| idealDistribution |
	idealDistribution := Dictionary new.
	idealDistribution at: #AtomicBomb put: 2.
	idealDistribution at: #Empty put: 55.
	idealDistribution at: #MoonWalk put: 5.
	idealDistribution at: #SpeedUp put: 15.
	idealDistribution at: #TimeMachine put: 8.
	idealDistribution at: #WormHole put: 15.
	^ idealDistribution
]

{ #category : #tests }
BoardTest >> testEmptyBoardHasNoSpecialSpots [
	| board |
	board := Board emptyWithSpots: 10 andNumberOfLaps: 5.
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
				= self idealDistribution ]
]
