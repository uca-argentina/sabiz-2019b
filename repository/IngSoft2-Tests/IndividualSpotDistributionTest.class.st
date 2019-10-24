"
This class contains tests about individual spot distributions
"
Class {
	#name : #IndividualSpotDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
IndividualSpotDistributionTest >> testCantCreateDistributionOfInvalidSpotType [
	self
		should:
			[ IndividualSpotDistribution of: Object withProbability: 70 ]
		raise: AssertionFailure
]

{ #category : #tests }
IndividualSpotDistributionTest >> testCantCreateDistributionWithInvalidProbabilityValue [
	self
		should:
			[ IndividualSpotDistribution of: Regular withProbability: -1 ]
		raise: AssertionFailure
]
