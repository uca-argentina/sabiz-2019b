"
This is a superclass for the tests in this model, containing the resources to be repeatedly used in multiple test subclasses. Most test classes are a ModelTest, and shares the common elements that will be tested
"
Class {
	#name : #ModelTest,
	#superclass : #TestCase,
	#instVars : [
		'player1',
		'player2',
		'player3',
		'testResource'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
ModelTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	testResource := ModelTestResource new.
	player1 := Player named: #Player1.
	player2 := Player named: #Player2.
	player3 := Player named: #Player3
]

{ #category : #testResourceTests }
ModelTest >> testTestResourceYieldsValidObjects [
	self assert: testResource standardGame class equals: Game.
	self assert: testResource standardBoard class equals: Board.
	self assert: (testResource boardWith: testResource standardEffectDistribution andSpots: 10 andLaps: 2) class equals: Board.
	self assert: (testResource effectlessBoardWithSpots: 10 andLaps: 2) class equals: Board.
	self assert: (testResource standardBoardWithSpots: 10 andLaps: 2) class equals: Board.
	self assert: (testResource effectTestingBoardWithSpots: 10 and: NullEffect new at: 4) class equals: Board.
]
