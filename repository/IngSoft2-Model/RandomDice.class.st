"
A good old classic dice
"
Class {
	#name : #RandomDice,
	#superclass : #Dice,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomDice class >> withFaces: faces [
	self
		assert: faces > 3 
		description: 'Number of Faces should be greater than three'.
	^ self new initializeWith: faces
]

{ #category : #initialization }
RandomDice >> initializeWith: numberOfFaces [
	faces := 1 to: numberOfFaces
]

{ #category : #rolling }
RandomDice >> roll [
	^ faces atRandom
]
