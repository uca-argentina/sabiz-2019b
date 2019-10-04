"
A Dice superclass
"
Class {
	#name : #Dice,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #roll }
Dice >> roll [
	self subclassResponsibility
]
