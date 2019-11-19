"
This class contains tests about dices
"
Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testCantCreateSequentialDiceWithEmptySequence [
	self
		should: [ SequentialDice withSequence: {} ]
		raise: AssertionFailure
]

{ #category : #tests }
DiceTest >> testRandomDiceCreationFailsWhenGivenNumberOfFacesIsLessThanFour [
	self should: [ RandomDice withFaces: 2 ] raise: AssertionFailure
]

{ #category : #tests }
DiceTest >> testRandomDiceRollsValidNumber [
	| dice faces result |
	faces := 6.
	dice := RandomDice withFaces: faces.
	result := dice roll.
	self assert: [ result > 0 and: result <= faces ]
]

{ #category : #tests }
DiceTest >> testSequentialDiceRollsExpectedSequence [
	| dice rolledSequence |
	rolledSequence := OrderedCollection new.
	dice := SequentialDice withSequence: {1 . 2 . 3 }.
	rolledSequence add: dice roll.
	rolledSequence add: dice roll.
	rolledSequence add: dice roll.
	rolledSequence add: dice roll.
	self assert: [ rolledSequence asArray = {1 . 2 . 3 . 1} ]
]
