"
This class contains tests about individual spot distributions
"
Class {
	#name : #IndividualEffectDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
IndividualEffectDistributionTest >> testCantCreateDistributionOfInvalidSpotType [
	self
		should:
			[ IndividualEffectProbability of: Object withProbability: 70 ]
		raise: AssertionFailure
]

{ #category : #tests }
IndividualEffectDistributionTest >> testCantCreateDistributionWithInvalidProbabilityValue [
	self
		should:
			[ IndividualEffectProbability of: Regular withProbability: -1 ]
		raise: AssertionFailure
]
