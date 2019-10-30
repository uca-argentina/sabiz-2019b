"
Everybody else goes back N spots
"
Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'numberOfSpotsToGoBack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> goingBack: numberOfSpotsToGoBack [
	self
		assert: [ numberOfSpotsToGoBack > 0 ]
		description: 'Number Of Spots to Go back must be greater than zero'.
	^ self new initializeWith: numberOfSpotsToGoBack
]

{ #category : #effect }
MoonWalk >> applyOn: gameState triggeredBy: player [
	| playersToApplyEffect |
	playersToApplyEffect := gameState players.
	playersToApplyEffect remove: player.
	playersToApplyEffect do: [ :each | gameState move: each ]
]

{ #category : #standardValues }
MoonWalk >> defaultGoBackValue [
	^ 4
]

{ #category : #initialization }
MoonWalk >> initialize [
	super initialize.
	numberOfSpotsToGoBack := self defaultGoBackValue
]

{ #category : #initialization }
MoonWalk >> initializeWith: spotsToGoBack [
	numberOfSpotsToGoBack := spotsToGoBack
]

{ #category : #accessing }
MoonWalk >> numberOfSpotsToGoBack [
	^ -1 * numberOfSpotsToGoBack
]
