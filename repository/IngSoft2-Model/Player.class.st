"
This class models a player consisting of a list of states, the last one being its current, a name, and a set of cards to be played
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'playerName',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> named: playerName holding: cards [
	^ self new initializeNamed: playerName holding: cards
]

{ #category : #comparing }
Player >> = player [
	^ self playerName = player playerName
]

{ #category : #initialization }
Player >> initializeNamed: aName holding: aSetOfCards [
	playerName := aName.
	cards := aSetOfCards
]

{ #category : #accessing }
Player >> playerName [
	^ playerName
]
