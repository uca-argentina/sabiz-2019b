"
Imitates the behaviour of the last played card
"
Class {
	#name : #RedoEffect,
	#superclass : #CardInstantEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
RedoEffect >> applyOn: target on: aGame triggeredBy: aPlayer [
	aGame replayLastCardOn: target for: aPlayer
]
