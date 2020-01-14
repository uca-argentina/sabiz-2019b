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
BoardTest >> testBoardHasGivenNumberOfSpots [
	| board |
	board := testResource standardBoardWithSpots: 20.
	self assert: [ board numberOfSpots = 20 ]
]

{ #category : #tests }
BoardTest >> testCreatingACustomBoardRequiresCollectionOfSpotsToUse [
	self
		should: [ Board with: {} ]
		raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testCustomBoardHasGivenEffectsInTheCorrespondingPosition [
	| board spots |
	spots := self allSpotTypes.
	board := Board with: spots.
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
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ testResource standardBoardWithSpots: 0 ]
			raise: AssertionFailure;
		should: [ testResource standardBoardWithSpots: -1 ]
			raise: AssertionFailure
]
