"
This class contains tests about boards
"
Class {
	#name : #BoardTest,
	#superclass : #StandardModelTest,
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
	board := Board newWith: 10 and: 2.
	self assert: [ board numberOfLaps = 2 ]
]

{ #category : #'test - accessing' }
BoardTest >> testBoardHasGivenNumberOfSpots [
	| board |
	board := Board newWith: 20 and: 2.
	self assert: [ board numberOfSpots = 20 ]
]

{ #category : #tests }
BoardTest >> testCustomBoardHasParticularEffectAtGivenPosition [
	| board spots |
	spots := self allSpotTypes.
	board := Board new initializeWith: spots andLaps: 5.
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
		should: [ Board newWith: 10 and: 0 ] raise: AssertionFailure;
		should: [ Board newWith: 10 and: -1 ] raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ Board newWith: 0 and: 2 ] raise: AssertionFailure;
		should: [ Board newWith: -1 and: 2 ] raise: AssertionFailure
]
