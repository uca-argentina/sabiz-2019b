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
SequentialDice class >> withRollingSequence: sequence [
	self
		assert: [ sequence isNotEmpty ]
		description: 'Tried to create a sequence dice with an empty sequence'.
	^ self new withRollingSequence: sequence
]

{ #category : #roll }
SequentialDice >> roll [
	lastRolledIndex := (lastRolledIndex + 1) % rollingSequence size.
	^ rollingSequence at: lastRolledIndex + 1
]

{ #category : #initialization }
SequentialDice >> withRollingSequence: sequence [
	rollingSequence := sequence copy.
	lastRolledIndex := sequence size - 1
]
