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
	self assert: loadedValue > 0 description: 'LoadedValue cannot be negative or zero'.
	^ self new initializeLoadedWith: loadedValue
]

{ #category : #iniatialization }
LoadedDice >> initializeLoadedWith: loadedFace [
	
	loadValue := loadedFace 
]

{ #category : #roll }
LoadedDice >> roll [
	^ loadValue 
]
