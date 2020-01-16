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

{ #category : #accessing }
PlayedCard >> target [
	^ target copy
]
