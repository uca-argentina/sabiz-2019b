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
	self assert: [ loadedValue >= 4 ] description: 'loadedValue cant be lesser than 4'.
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
