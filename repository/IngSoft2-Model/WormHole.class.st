"
Go back 4 spots
"
Class {
	#name : #WormHole,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #'standard values' }
WormHole class >> probability [
	^ 15
]

{ #category : #effect }
WormHole >> applyEffectOn: gameState triggeredBy: player [
	(gameState playerHasNotFinished: player)
		ifTrue: [ gameState player: player advances: self numberOfSpotsToGoBack ]
]

{ #category : #effect }
WormHole >> numberOfSpotsToGoBack [
	^ -4
]
