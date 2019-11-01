"
This class contains tests about individual spot distributions
"
Class {
	#name : #IndividualOccurrenceDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
IndividualOccurrenceDistributionTest >> testCantCreateDistributionWithNegativeProbabilityValue [
	self
		should: [ IndividualOccurrenceProbability of: NullEffect withProbability: -1 ]
		raise: AssertionFailure
]

{ #category : #tests }
IndividualOccurrenceDistributionTest >> testCantCreateDistributionWithProbabilityValueOverAHundred [
	self
		should: [ IndividualOccurrenceProbability of: NullEffect withProbability: 101 ]
		raise: AssertionFailure
]
