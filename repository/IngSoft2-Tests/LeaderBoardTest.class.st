"
This class contains tests about LeaderBoard
"
Class {
	#name : #LeaderBoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LeaderBoardTest >> testCantAddDuplicatedValuesToLeaderBoard [
	| leaderboard |
	leaderboard := LeaderBoard newLeadBoard.
	leaderboard add: 'element'.
	self should: [ leaderboard add: 'element' ] raise: AssertionFailure
]

{ #category : #tests }
LeaderBoardTest >> testCantModifyElementsAlreadyInLeaderboard [
	| leaderboard element |
	leaderboard := LeaderBoard newLeadBoard.
	leaderboard add: OrderedCollection new.
	element := leaderboard first.
	element
		add: 'Trying to change element that is already in LeaderBoard'.
	self assert: [ leaderboard first isEmpty ]
]

{ #category : #tests }
LeaderBoardTest >> testElementsAreInsertedAsCopies [
	| leaderboard element |
	element := OrderedCollection new.
	leaderboard := LeaderBoard newLeadBoard.
	leaderboard add: element.
	element add: 'change object after adding'.
	self deny: element size = leaderboard first size
]

{ #category : #tests }
LeaderBoardTest >> testElementsInLeaderBoardRespectAdditionOrder [
	| leaderboard |
	leaderboard := LeaderBoard newLeadBoard.
	leaderboard add: 1.
	leaderboard add: 2.
	leaderboard add: 3.
	leaderboard add: 4.
	leaderboard add: 5.
	leaderboard add: 6.
	leaderboard add: 7.
	leaderboard add: 8.
	leaderboard add: 9.
	leaderboard add: 10.
	leaderboard add: 11.
	self assert: [ leaderboard size = 11 ].
	self assert: [ leaderboard first = 1 ].
	self assert: [ leaderboard second = 2 ].
	self assert: [ leaderboard third = 3 ].
	self assert: [ leaderboard fourth = 4 ].
	self assert: [ leaderboard fifth = 5 ].
	self assert: [ leaderboard sixth = 6 ].
	self assert: [ leaderboard seventh = 7 ].
	self assert: [ leaderboard eighth = 8 ].
	self assert: [ leaderboard ninth = 9 ].
	self assert: [ (leaderboard at: 10) = 10 ].
	self assert: [ leaderboard last = 11 ]
]
