"
a LoadedDice with negative roll result in order to test backwards movement.
"
Class {
	#name : #NegativeLoadedDice,
	#superclass : #Dice,
	#instVars : [
		'rollResult'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
NegativeLoadedDice class >> loadedWith: loadedValue [
	self assert: [ loadedValue <= -4 ].
	^ self new initializeLoadedWith: loadedValue
]

{ #category : #initialization }
NegativeLoadedDice >> initializeLoadedWith: loadedValue [
	rollResult := loadedValue
]

{ #category : #roll }
NegativeLoadedDice >> roll [
	^ rollResult
]
