"
This class contains tests about boards
"
Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'test - accessing' }
BoardTest >> testBoardHasGivenNumberOfLaps [
	| board |
	board := Board
		withDistribution: OverallSpotDistribution standard
		numberOfSpots: 10
		andNumberOfLaps: 2.
	self assert: [ board numberOfLaps = 2 ]
]

{ #category : #'test - accessing' }
BoardTest >> testBoardHasGivenNumberOfSpots [
	| board |
	board := Board
		withDistribution: OverallSpotDistribution standard
		numberOfSpots: 20
		andNumberOfLaps: 2.
	self assert: [ board numberOfSpots = 20 ]
]

{ #category : #tests }
BoardTest >> testCreatingACustomBoardRequiresCollectionOfSpotsToUse [
	self
		should: [ Board withSpotCollection: {} andNumberOfLaps: 5 ]
		raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testCustomBoardHasParticularEffectAtGivenPosition [
	| board |
	board := Board
		withSpotCollection:
			{Regular new.
			MoonWalk new.
			WormHole new.
			TimeMachine new.
			SpeedUp new.
			AtomicBomb new}
		andNumberOfLaps: 5.
	self assert: (board spotAt: 1) className asSymbol == #Regular.
	self assert: (board spotAt: 2) className asSymbol == #MoonWalk.
	self assert: (board spotAt: 3) className asSymbol == #WormHole.
	self assert: (board spotAt: 4) className asSymbol == #TimeMachine.
	self assert: (board spotAt: 5) className asSymbol == #SpeedUp.
	self assert: (board spotAt: 6) className asSymbol == #AtomicBomb
]

{ #category : #tests }
BoardTest >> testEmptyBoardHasNoSpecialSpots [
	| board |
	board := Board regularWithNumberOfSpots: 5 andNumberOfLaps: 5.
	board spots
		do: [ :each | self assert: [ each className asSymbol = #Regular ] ]
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfLaps [
	self
		should: [ Board
				withDistribution: OverallSpotDistribution standard
				numberOfSpots: 10
				andNumberOfLaps: 0 ]
			raise: AssertionFailure;
		should: [ Board
				withDistribution: OverallSpotDistribution standard
				numberOfSpots: 10
				andNumberOfLaps: -1 ]
			raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ Board
				withDistribution: OverallSpotDistribution standard
				numberOfSpots: 0
				andNumberOfLaps: 2 ]
			raise: AssertionFailure;
		should: [ Board
				withDistribution: OverallSpotDistribution standard
				numberOfSpots: -1
				andNumberOfLaps: 2 ]
			raise: AssertionFailure
]
