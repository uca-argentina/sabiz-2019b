"
This class represents a cards that has been played on a target
"
Class {
	#name : #PlayedCard,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayedCard class >> of: effect to: target [
	^ self new of: effect to: target
]

{ #category : #comparing }
PlayedCard >> = playedCard [
	^ playedCard class = PlayedCard
		and: [ self effect class = playedCard effect class
				and: target = playedCard target ]
]

{ #category : #comparing }
PlayedCard >> hash [
	^ (self effect className hash + target hash) asString hash
]

{ #category : #'instance creation' }
PlayedCard >> of: anEffect to: aTarget [
	effect := anEffect.
	target := aTarget
]

{ #category : #accessing }
PlayedCard >> target [
	^ target copy
]
