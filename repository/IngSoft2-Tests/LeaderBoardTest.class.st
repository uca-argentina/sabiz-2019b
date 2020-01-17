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
	leaderboard := LeaderBoard new.
	leaderboard add: 'element'.
	self should: [ leaderboard add: 'element' ] raise: AssertionFailure
]

{ #category : #tests }
LeaderBoardTest >> testCantModifyElementsAlreadyInLeaderboard [
	| leaderboard element |
	leaderboard := LeaderBoard new.
	leaderboard add: OrderedCollection new.
	element := leaderboard at: 1.
	element
		add: 'Trying to change element that is already in LeaderBoard'.
	self assert: (leaderboard at: 1) isEmpty
]

{ #category : #tests }
LeaderBoardTest >> testElementsAreInsertedAsCopies [
	| leaderboard element |
	element := OrderedCollection new.
	leaderboard := LeaderBoard new.
	leaderboard add: element.
	element add: 'change object after adding'.
	self deny: element size equals: (leaderboard at: 1) size
]

{ #category : #tests }
LeaderBoardTest >> testElementsInLeaderBoardRespectAdditionOrder [
	| leaderboard |
	leaderboard := LeaderBoard new.
	leaderboard add: 1.
	leaderboard add: 2.
	leaderboard add: 3.
	self assert: leaderboard size equals: 3.
	self assert: (leaderboard at: 1) equals: 1.
	self assert: (leaderboard at: 2) equals: 2.
	self assert: (leaderboard at: 3) equals: 3
]
