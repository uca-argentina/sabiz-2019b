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
	player1 := Player named: #player1.
	player2 := Player named: #player2.
	player3 := Player named: #player3
]
