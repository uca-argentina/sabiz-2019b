Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testDiceHasGivenNumberOfFaces [
]

{ #category : #tests }
DiceTest >> testDiceLoadedWithFiveReturnFiveWhenItIsRolled [
	| dice |
	dice := LoadedDice loadedWith: 5.
	self assert: dice roll equals: 5
]

{ #category : #tests }
DiceTest >> testRandomDiceCreationFailsWhenGivenNumberOfFacesIsLessThanFour [

	self
		should: [ RandomDice with: 2 ]
		raise: Error 
	
]

{ #category : #tests }
DiceTest >> testRandomDiceRollsValidNumber [
	| dice faces result |
	
	faces := 6 .
	dice := RandomDice with: faces .
	result := dice roll .
	
	self assert: (result > 0 and: result <= faces) .
]

{ #category : #tests }
DiceTest >> testRandomDiceWithSixFacesRollsNumberBetweenOneAndSix [
	
	| dice roll |
	dice := RandomDice with: 6.
	roll := dice roll.
	self assert: roll <= 6.
	self assert: roll >= 1
]
