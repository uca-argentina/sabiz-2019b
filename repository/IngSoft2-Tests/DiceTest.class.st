"
This class contains tests about dices
"
Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #sequentialDiceTests }
DiceTest >> testCantCreateSequentialDiceWithEmptySequence [
	self
		should: [ SequentialDice withSequence: {} ]
		raise: AssertionFailure
]

{ #category : #sequentialDiceTests }
DiceTest >> testCantRemoveUnexistingElementFromSequentialDice [
	| dice |
	dice := SequentialDice withSequence: {1 . 2}.
	dice removeFromSequence: 1.
	self should: [ dice removeFromSequence: 1 ] raise: AssertionFailure
]

{ #category : #randomDiceTests }
DiceTest >> testRandomDiceCreationFailsWhenGivenNumberOfFacesIsLessThanFour [
	self should: [ RandomDice withFaces: 2 ] raise: AssertionFailure
]

{ #category : #randomDiceTests }
DiceTest >> testRandomDiceRollsValidNumber [
	| dice faces result |
	faces := 6.
	dice := RandomDice withFaces: faces.
	result := dice roll.
	self assert: [ result > 0 and: result <= faces ]
]

{ #category : #sequentialDiceTests }
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

{ #category : #sequentialDiceTests }
DiceTest >> testSequentialDiceRollsExpectedSequenceAfterRemovingElement [
	| dice rolledSequence |
	rolledSequence := OrderedCollection new.
	dice := SequentialDice withSequence: {1 . 2 . 3 }.
	rolledSequence add: dice roll.
	rolledSequence add: dice roll.
	rolledSequence add: dice roll.
	dice removeFromSequence: 1.
	rolledSequence add: dice roll.
	self assert: [ rolledSequence asArray = {1 . 2 . 3 . 2} ]
]
