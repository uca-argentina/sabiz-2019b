"
This class represents an instant effect produced by playing a card
"
Class {
	#name : #RepeatEffect,
	#superclass : #CardInstantEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
RepeatEffect >> applyOn: target on: aGame triggeredBy: aPlayer [
	| history position |
	self assert: target size = 1 description: 'The repeat card can only be played on a single player'.
	history := aGame historyOf: aPlayer.
	history size < 2
		ifTrue: [ AssertionFailure
				signal: 'Cant play that card because the target never rolled the dices' ].
	"si paso el turno del jugador uso esta ronda, sino la anterior (la ronda 0 esta cubierta por el avvert anterior)"
	"calcular position!!!!!!!! cual es? la segunda de cada vuelta? la penultima? guardo un registro de todos los triggers en board o game?"
	position := aGame positionOf: target first.
	aGame player: aPlayer triggersEffectAt: position
]
