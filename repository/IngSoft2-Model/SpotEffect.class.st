"
A class used to create the effects that can be assigned to a spot
"
Class {
	#name : #SpotEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpotEffect >> applyOn: game triggeredBy: player in: state [
	self subclassResponsibility
]
