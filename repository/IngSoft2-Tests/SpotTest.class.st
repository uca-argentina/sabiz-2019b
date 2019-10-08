"
This class contains tests about spots.
"
Class {
	#name : #SpotTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpotTest >> testAllProbabilitiesAddUpToOneHundred [
	self
		assert: [ (Spot allSubclasses
				inject: 0
				into: [ :sum :each | sum + each probability ]) = 100 ]
]
