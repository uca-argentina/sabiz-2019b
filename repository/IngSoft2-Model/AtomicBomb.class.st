"
Resets all players to the starting position, keeping their row number
"
Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
AtomicBomb >> applyOn: gameState triggeredBy: player [
	| players |
	players := gameState players.
	self moveAll: players toFirstSpotUpdating: gameState
]

{ #category : #effect }
AtomicBomb >> moveAll: players toFirstSpotUpdating: gameState [
	players do:
		[ :each | gameState move: each ]
]
