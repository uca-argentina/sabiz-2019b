"
This class contains tests about boards
"
Class {
	#name : #BoardTest,
	#superclass : #ModelTest,
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
	board := testResource standardBoardWithSpots: 10 andLaps: 2.
	self assert: [ board numberOfLaps = 2 ]
]

{ #category : #'test - accessing' }
BoardTest >> testBoardHasGivenNumberOfSpots [
	| board |
	board := testResource standardBoardWithSpots: 20 andLaps: 2.
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
BoardTest >> testEffectTestingBoardHasGivenEffectAtDesiredPositionAndNoEffectsElsewhere [
	| effect board |
	effect := MoonWalkEffect new.
	board := testResource
		effectTestingBoardWithSpots: testResource standardNumberOfSpots
		and: effect
		at: 1.
	1 to: board numberOfSpots do: [ :index | 
		index == 1
			ifTrue: [ self assert: (board spotAt: index) effect equals: effect ]
			ifFalse: [ self assert: (board spotAt: index) effect class equals: NullEffect ] ]
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfLaps [
	self
		should: [ testResource standardBoardWithSpots: 10 andLaps: 0 ]
			raise: AssertionFailure;
		should: [ testResource standardBoardWithSpots: 10 andLaps: -1 ]
			raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ testResource standardBoardWithSpots: 0 andLaps: 2 ]
			raise: AssertionFailure;
		should: [ testResource standardBoardWithSpots: -1 andLaps: 2 ]
			raise: AssertionFailure
]
