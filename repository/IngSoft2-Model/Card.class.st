"
This class models cards that can be held and played
"
Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Card class >> newWith: anEffect [
	^ self new initializeWith: anEffect
]

{ #category : #initialization }
Card >> initializeWith: anEffect [
	effect := anEffect
]
