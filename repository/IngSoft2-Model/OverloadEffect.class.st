"
This effect reduces the rollSum of a given player by 2
"
Class {
	#name : #OverloadEffect,
	#superclass : #CardPermanentEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #evaluating }
OverloadEffect >> value [
	^ -2
]
