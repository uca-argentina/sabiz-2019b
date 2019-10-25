"
This class contains tests about boards
"
Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #extracted }
BoardTest >> allEffectTypes [
	^ (Effect allSubclasses collect: [ :each | each new ]) asArray
]

{ #category : #'test - accessing' }
BoardTest >> testBoardHasGivenNumberOfLaps [
	| board |
	board := Board
		with: OverallSpotDistribution standard
		andSpots: 10
		andLaps: 2.
	self assert: [ board numberOfLaps = 2 ]
]

{ #category : #'test - accessing' }
BoardTest >> testBoardHasGivenNumberOfSpots [
	| board |
	board := Board
		with: OverallSpotDistribution standard
		andSpots: 20
		andLaps: 2.
	self assert: [ board numberOfSpots = 20 ]
]

{ #category : #tests }
BoardTest >> testCreatingACustomBoardRequiresCollectionOfSpotsToUse [
	self
		should: [ Board with: {} andLaps: 5 ]
		raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testCustomBoardHasParticularEffectAtGivenPosition [
	| board effects |
	effects := self allEffectTypes.
	board := Board with: effects andLaps: 5.
	effects
		withIndexDo: [ :effect :index | self assert: (board spotAt: index) equals: effect ]
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfLaps [
	self
		should: [ Board
				with: OverallSpotDistribution standard
				andSpots: 10
				andLaps: 0 ]
			raise: AssertionFailure;
		should: [ Board
				with: OverallSpotDistribution standard
				andSpots: 10
				andLaps: -1 ]
			raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ Board
				with: OverallSpotDistribution standard
				andSpots: 0
				andLaps: 2 ]
			raise: AssertionFailure;
		should: [ Board
				with: OverallSpotDistribution standard
				andSpots: -1
				andLaps: 2 ]
			raise: AssertionFailure
]
