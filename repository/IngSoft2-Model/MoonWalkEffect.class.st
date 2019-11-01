"
Everybody else goes back N spots
"
Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'numberOfSpotsToGoBack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkEffect class >> goingBack: numberOfSpotsToGoBack [
	self
		assert: [ numberOfSpotsToGoBack > 0 ]
		description: 'Number Of Spots to Go back must be greater than zero'.
	^ self new initializeWith: numberOfSpotsToGoBack
]

{ #category : #effect }
MoonWalkEffect >> applyOn: game triggeredBy: player in: state [
	game set: state for: player.
	game
		player: player
		triggersMoonWalkEffectMoving: self numberOfSpotsToGoBack
]

{ #category : #standardValues }
MoonWalkEffect >> defaultGoBackValue [
	^ 4
]

{ #category : #initialization }
MoonWalkEffect >> initialize [
	super initialize.
	numberOfSpotsToGoBack := self defaultGoBackValue
]

{ #category : #initialization }
MoonWalkEffect >> initializeWith: spotsToGoBack [
	numberOfSpotsToGoBack := spotsToGoBack
]

{ #category : #accessing }
MoonWalkEffect >> numberOfSpotsToGoBack [
	^ -1 * numberOfSpotsToGoBack
]
