"
This class contains tests about individual spot distributions
"
Class {
	#name : #IndividualOccurrenceProbabilityTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
IndividualOccurrenceProbabilityTest >> testCantCreateDistributionWithNegativeProbabilityValue [
	self
		should: [ IndividualOccurrenceProbability of: NullEffect withProbability: -1 ]
		raise: AssertionFailure
]

{ #category : #tests }
IndividualOccurrenceProbabilityTest >> testCantCreateDistributionWithProbabilityValueOverAHundred [
	self
		should: [ IndividualOccurrenceProbability of: NullEffect withProbability: 101 ]
		raise: AssertionFailure
]
