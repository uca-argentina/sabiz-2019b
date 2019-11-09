"
This class models a card permanent effects that can be applied to one or more players, and can be accumulated
"
Class {
	#name : #CardPermanentEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #evaluating }
CardPermanentEffect >> value [
	self subclassResponsibility
]
