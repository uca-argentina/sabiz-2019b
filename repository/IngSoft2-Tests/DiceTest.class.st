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
	| dice |
	self
		should: [ SequentialDice rollingSequence: {} ]
		raise: AssertionFailure
]

{ #category : #tests }
DiceTest >> testDiceLoadedWithFiveReturnFiveWhenItIsRolled [
	| dice |
	dice := LoadedDice loadedWith: 5.
	self assert: dice roll equals: 5
]

{ #category : #tests }
DiceTest >> testLoadedDiceCreationFailsWhenLoadedValueIsLessThanFour [
	self should: [ LoadedDice loadedWith: (-4) ] raise: AssertionFailure
]

{ #category : #tests }
DiceTest >> testNegativeLoadedDiceCreationFailsWhenTheLoadedValueIsBiggerThanNegative4 [
	self should: [ NegativeLoadedDice loadedWith: 2 ] raise: AssertionFailure 
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
	self assert: (result > 0 and: result <= faces)
]

{ #category : #tests }
DiceTest >> testSequentialDiceRollsExpectedSequence [
	| dice rolledSequence |
	rolledSequence := OrderedCollection new.
	dice := SequentialDice rollingSequence: {1 . 2 . 3 . 4}.
	rolledSequence add: dice roll.
	rolledSequence add: dice roll.
	rolledSequence add: dice roll.
	rolledSequence add: dice roll.
	rolledSequence add: dice roll.
	self assert: rolledSequence asArray equals: {1 . 2 . 3 . 4 . 1}
]
