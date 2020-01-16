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
		assert: [ sequence isNotEmpty ]
		description: 'Tried to create a sequence dice with an empty sequence'.
	^ self new initializeWithSequence: sequence
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
	(rollingSequence
		indexOf: element
		ifAbsent: [ AssertionFailure
				signal:
					'Tried to remove a non existent element from the sequence of a sequential dice' ])
		<= lastRolledIndex
		ifTrue: [ lastRolledIndex := lastRolledIndex - 1 ].
	rollingSequence remove: element.
	lastRolledIndex < 0
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
