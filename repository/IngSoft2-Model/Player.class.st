"
This class models a player consisting of a list of states, the last one being its current, a name, and a set of cards to be played
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'playerName',
		'states',
		'cardsInHand'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> named: playerName [
	^ self new initializeNamed: playerName
]

{ #category : #comparing }
Player >> = player [
	^ self name = player name
]

{ #category : #accessing }
Player >> cardsInHand [
	^ cardsInHand
]

{ #category : #initialization }
Player >> initializeNamed: aName [
	playerName := aName.
	cardsInHand := OrderedCollection new
]

{ #category : #accessing }
Player >> name [
	^ playerName
]
