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
	playersToApplyEffect
		do:
			[ :each | gameState player: each advances: self numberOfSpotsToGoBack ]
]

{ #category : #defaultValues }
MoonWalk >> defaultGoBackValue [
	^ 4
]

{ #category : #initialization }
MoonWalk >> initialize [
	numberOfSpotsToGoBack := self defaultGoBackValue
]

{ #category : #initialization }
MoonWalk >> initializeWith: spotsToGoBack [
	numberOfSpotsToGoBack := spotsToGoBack
]

{ #category : #effect }
MoonWalk >> numberOfSpotsToGoBack [
	^ numberOfSpotsToGoBack * -1
]
