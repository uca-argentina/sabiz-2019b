"
This class contains tests about dices
"
Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
	dice := RandomDice withFaces: faces .
	result := dice roll .
	self assert: (result > 0 and: result <= faces) .
]
