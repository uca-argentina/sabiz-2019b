"
A dice that always rolls the same number
"
Class {
	#name : #LoadedDice,
	#superclass : #Dice,
	#instVars : [
		'loadValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDice class >> loadedWith: loadedValue [
	self
		assert: loadedValue > 0
		description: 'LoadedValue cannot be negative or zero'.
	^ self new initializeLoadedWith: loadedValue
]

{ #category : #initialization }
LoadedDice >> initializeLoadedWith: loadedFace [
	loadValue := loadedFace
]

{ #category : #roll }
LoadedDice >> roll [
	^ loadValue
]
