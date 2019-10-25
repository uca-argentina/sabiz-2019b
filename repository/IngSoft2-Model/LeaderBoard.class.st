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

{ #category : #adding }
LeaderBoard >> add: anElement [
	elements
		addIfNotPresent: anElement copy
		ifPresentDo: [ AssertionFailure signal: 'Element already in leaderboard' ]
]

{ #category : #accessing }
LeaderBoard >> at: position [
	^ (elements at: position) copy
]

{ #category : #initialization }
LeaderBoard >> initialize [
	super initialize.
	elements := OrderedCollection new
]

{ #category : #testing }
LeaderBoard >> isNotEmpty [
	^ elements isNotEmpty
]

{ #category : #accessing }
LeaderBoard >> positions [
	^ elements asArray
]

{ #category : #accessing }
LeaderBoard >> size [
	^ elements size
]

{ #category : #accessing }
LeaderBoard >> winner [
	self
		assert: [ self isNotEmpty ]
		description: 'No one has reached the end yet'.
	^ self at: 1
]
