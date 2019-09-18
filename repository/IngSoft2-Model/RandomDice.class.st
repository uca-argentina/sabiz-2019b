Class {
	#name : #RandomDice,
	#superclass : #Dice,
	#instVars : [
		'rollResult',
		'random'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RandomDice class >> with: faces [

	self assert: faces > 3 description: 'Number of Faces should be greater than three'.
	^self new initializeWith: faces
]

{ #category : #initialization }
RandomDice >> initializeWith: faces [
	numberOfFaces := faces.
	random := Random new 
]

{ #category : #rolling }
RandomDice >> roll [
	rollResult := random nextInt: numberOfFaces.
	^ rollResult 
]
