"
Everybody else goes back N spots
"
Class {
	#name : #MoonWalk,
	#superclass : #Spot,
	#instVars : [
		'numberOfSpotsToGoBack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> newLoadedWith: numberOfSpotsToGoBack [
	self
		assert: [ numberOfSpotsToGoBack < 6 and: numberOfSpotsToGoBack > 0 ]
		description:
			'Number Of Spots to Go back for MoonWalk effect must be between 1 and 5 included both'.
	^ self new initializeWith: numberOfSpotsToGoBack
]

{ #category : #'standard values' }
MoonWalk class >> probability [
	^ 5
]

{ #category : #effect }
MoonWalk >> applyEffectOn: gameState triggeredBy: player [
	| playersToApplyEffect |
	playersToApplyEffect := gameState players.
	playersToApplyEffect remove: player.
	playersToApplyEffect
		do: [ :each | 
			(gameState playerHasNotFinished: each)
				ifTrue: [ gameState player: each advances: self numberOfSpotsToGoBack ] ]
]

{ #category : #initialization }
MoonWalk >> initialize [
	| random |
	random := Random new.
	numberOfSpotsToGoBack := random nextInt: 5
]

{ #category : #'testing - initialization' }
MoonWalk >> initializeWith: spotsToGoBack [
	numberOfSpotsToGoBack := spotsToGoBack
]

{ #category : #effect }
MoonWalk >> numberOfSpotsToGoBack [
	^ numberOfSpotsToGoBack * -1
]
