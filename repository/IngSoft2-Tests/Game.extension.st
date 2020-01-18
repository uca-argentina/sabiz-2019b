Extension { #name : #Game }

{ #category : #'*IngSoft2-Tests' }
Game >> playAnEntireGameWithoutPlayingCards [
	[ self isNotOver ] whileTrue: [ self playOneRoundWithoutPlayingCards ]
]

{ #category : #'*IngSoft2-Tests' }
Game >> playOneRoundWithoutPlayingCards [
	| roundNumber |
	self assert: self isNotOver description: 'Game is already over'.
	roundNumber := turnAllocator currentRoundNumber.
	[ roundNumber = turnAllocator currentRoundNumber ]
		whileTrue: [ self throwDicesFor: turnAllocator playerWhoseTurnItIsToPlay ]
]
