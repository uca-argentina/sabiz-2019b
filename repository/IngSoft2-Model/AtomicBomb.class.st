"
Resets all players to the starting position, keeping their row number
"
Class {
	#name : #AtomicBomb,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #'standard values' }
AtomicBomb class >> probability [
	^ 2
]

{ #category : #effect }
AtomicBomb >> applyEffectOn: gameState triggeredBy: player [
	| players |
	players := gameState players.
	self moveAll: players toFirstSpotFrom: gameState
]

{ #category : #effect }
AtomicBomb >> moveAll: players toFirstSpotFrom: gameState [
	players
		do: [ :each | 
			(gameState playerHasNotFinished: each)
				ifTrue: [ gameState
						player: each
						advances: ((gameState positionOfPlayer: each) - 1) * -1 ] ]
]
