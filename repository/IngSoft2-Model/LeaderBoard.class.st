"
This class models a table that keeps track of the players that finished the game, and the order in which said players did so
"
Class {
	#name : #LeaderBoard,
	#superclass : #Object,
	#instVars : [
		'elements'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LeaderBoard class >> newLeadBoard [
	^ self new initializeLeaderBoard
]

{ #category : #adding }
LeaderBoard >> add: anElement [
	elements
		addIfNotPresent: anElement copy
		ifPresentDo: [ AssertionFailure signal ]
]

{ #category : #accessing }
LeaderBoard >> at: position [
	^ (elements at: position) copy
]

{ #category : #accessing }
LeaderBoard >> eighth [
	^ elements eighth copy
]

{ #category : #accessing }
LeaderBoard >> fifth [
	^ elements fifth copy
]

{ #category : #accessing }
LeaderBoard >> first [
	^ elements first copy
]

{ #category : #accessing }
LeaderBoard >> fourth [
	^ elements fourth copy
]

{ #category : #initialization }
LeaderBoard >> initializeLeaderBoard [
	elements := OrderedCollection new
]

{ #category : #testing }
LeaderBoard >> isNotEmpty [
	^ elements isNotEmpty
]

{ #category : #accessing }
LeaderBoard >> last [
	^ elements last copy
]

{ #category : #accessing }
LeaderBoard >> ninth [
	^ elements ninth copy
]

{ #category : #accessing }
LeaderBoard >> second [
	^ elements second copy
]

{ #category : #accessing }
LeaderBoard >> seventh [
	^ elements seventh copy
]

{ #category : #accessing }
LeaderBoard >> sixth [
	^ elements sixth copy
]

{ #category : #accessing }
LeaderBoard >> size [
	^ elements size
]

{ #category : #accessing }
LeaderBoard >> third [
	^ elements third copy
]
