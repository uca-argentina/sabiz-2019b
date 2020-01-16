"
Everybody else goes back N spots
"
Class {
	#name : #MoonWalkEffect,
	#superclass : #SpotEffect,
	#instVars : [
		'numberOfSpotsToGoBack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #standardValues }
MoonWalkEffect class >> defaultGoBackValue [
	^ 4
]

{ #category : #'instance creation' }
MoonWalkEffect class >> goingBack: numberOfSpotsToGoBack [
	self
		assert: [ numberOfSpotsToGoBack > 0 ]
		description: 'Number Of Spots to Go back must be greater than zero'.
	^ super new initializeWith: numberOfSpotsToGoBack
]

{ #category : #'instance creation' }
MoonWalkEffect class >> new [
	^ self goingBack: self defaultGoBackValue
]

{ #category : #effect }
MoonWalkEffect >> applyOn: game triggeredBy: player [
	game
		player: player
		triggersMoonWalkEffectMoving: self numberOfSpotsToGoBack
]

{ #category : #initialization }
MoonWalkEffect >> initializeWith: spotsToGoBack [
	numberOfSpotsToGoBack := spotsToGoBack
]

{ #category : #accessing }
MoonWalkEffect >> numberOfSpotsToGoBack [
	^ -1 * numberOfSpotsToGoBack
]
