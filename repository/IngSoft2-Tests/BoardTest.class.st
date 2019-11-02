"
This class contains tests about boards
"
Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #extracted }
BoardTest >> allSpotTypes [
	^ (SpotEffect allSubclasses collect: [ :each | Spot with: each new ])
		asArray
]

{ #category : #'test - accessing' }
BoardTest >> testBoardHasGivenNumberOfLaps [
	| board |
	board := Board standardWithSpots: 10 andLaps: 2.
	self assert: [ board numberOfLaps = 2 ]
]

{ #category : #'test - accessing' }
BoardTest >> testBoardHasGivenNumberOfSpots [
	| board |
	board := Board standardWithSpots: 20 andLaps: 2.
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
	| board spots |
	spots := self allSpotTypes.
	board := Board with: spots andLaps: 5.
	spots
		withIndexDo: [ :spot :index | self assert: (board spotAt: index) equals: spot ]
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfLaps [
	self
		should: [ Board standardWithSpots: 10 andLaps: 0 ]
			raise: AssertionFailure;
		should: [ Board standardWithSpots: 10 andLaps: -1 ]
			raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ Board standardWithSpots: 0 andLaps: 2 ]
			raise: AssertionFailure;
		should: [ Board standardWithSpots: -1 andLaps: 2 ]
			raise: AssertionFailure
]
