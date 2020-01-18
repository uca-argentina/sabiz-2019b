"
This is a dice that continuously rolls a predetermined sequence of values
"
Class {
	#name : #SequentialDice,
	#superclass : #Dice,
	#instVars : [
		'rollingSequence',
		'lastRolledIndex'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SequentialDice class >> withSequence: sequence [
	self
		assert: sequence isNotEmpty
		description: 'Tried to create a sequence dice with an empty sequence'.
	^ self new initializeWithSequence: sequence
]

{ #category : #validation }
SequentialDice >> checkIfSizeOfSequenceAllowsForRemovalOfAnElement [
	self assert: rollingSequence size > 1 description: 'The last element of a sequence cannot be removed'
]

{ #category : #validation }
SequentialDice >> checkPresenceOf: element [
	(rollingSequence includes: element)
		ifFalse: [ AssertionFailure
				signal: 'This element is not present in the sequence of the dice' ]
]

{ #category : #initialization }
SequentialDice >> initializeWithSequence: sequence [
	rollingSequence := sequence asOrderedCollection copy.
	lastRolledIndex := sequence size - 1
]

{ #category : #accessing }
SequentialDice >> lastRolledIndex [
	^ lastRolledIndex
]

{ #category : #alteringSequence }
SequentialDice >> removeFromSequence: element [
	self checkPresenceOf: element.
	self checkIfSizeOfSequenceAllowsForRemovalOfAnElement.
	(rollingSequence indexOf: element) <= lastRolledIndex
		ifTrue: [ lastRolledIndex := lastRolledIndex - 1 ].
	rollingSequence remove: element.
	lastRolledIndex = -1
		ifTrue: [ lastRolledIndex := rollingSequence size - 1 ]
]

{ #category : #roll }
SequentialDice >> roll [
	self assert: rollingSequence isNotEmpty description: 'Tried to roll a sequential dice with an empty sequence'.
	lastRolledIndex := (lastRolledIndex + 1) % rollingSequence size.
	^ rollingSequence at: lastRolledIndex + 1
]

{ #category : #accessing }
SequentialDice >> sequenceSize [
	^ rollingSequence size
]
