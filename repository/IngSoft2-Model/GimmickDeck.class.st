"
A deck that deals cards in an expected sequence
"
Class {
	#name : #GimmickDeck,
	#superclass : #Deck,
	#instVars : [
		'dealingSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GimmickDeck class >> withSequence: dealingSequence [
	self assert: dealingSequence isNotEmpty description: 'Cant create a Gimmick Deck with an empty dealing sequence'.
	^ self new withSequence: dealingSequence
]

{ #category : #accessing }
GimmickDeck >> nextCard [
	^ dealingSequence roll
]

{ #category : #initialization }
GimmickDeck >> withSequence: sequence [
	dealingSequence := SequentialDice withSequence: sequence
]
