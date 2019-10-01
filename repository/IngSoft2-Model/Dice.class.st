"
A Dice superclass
"
Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #roll }
Dice >> roll [
	self subclassResponsibility
]
