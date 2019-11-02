"
This class models cards that can be held and played
"
Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Card class >> random [
	^ self new
]

{ #category : #'set creation' }
Card class >> startingSet [
	| set |
	set := OrderedCollection new.
	self startingSetSize timesRepeat: [ set add: self random ].
	^ set asArray
]

{ #category : #standardValues }
Card class >> startingSetSize [
	^ 2
]
