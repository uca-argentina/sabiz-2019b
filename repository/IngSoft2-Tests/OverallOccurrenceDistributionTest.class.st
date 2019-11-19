"
This class contains tests about overall spot distributions
"
Class {
	#name : #OverallOccurrenceDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
OverallOccurrenceDistributionTest >> assertPercentageOf: element in: collection is: expectedPercentage within: tolerance [
	| percentage |
	percentage := ((collection count: [ :each | each = element ]) / collection size) * 100.
	self assert: (percentage - expectedPercentage) abs <= tolerance
]

{ #category : #tests }
OverallOccurrenceDistributionTest >> testCantCreateEmptyDistribution [
	self
		should: [ OverallOccurrenceDistribution with: {} ]
		raise: AssertionFailure
]

{ #category : #tests }
OverallOccurrenceDistributionTest >> testDistributionYieldsExpectedProbabilityForEachElement [
	| distribution generation tolerance |
	tolerance := 5.
	distribution := OverallOccurrenceDistribution with:
			{(IndividualOccurrenceProbability of: #element1 withProbability: 20).
			(IndividualOccurrenceProbability of: #element2 withProbability: 30).
			(IndividualOccurrenceProbability of: #element3 withProbability: 50)}.
	generation := distribution generate: 1000.
	self assertPercentageOf: #element1 in: generation is: (distribution probabilityOf: #element1) within: tolerance.
	self assertPercentageOf: #element2 in: generation is: (distribution probabilityOf: #element2) within: tolerance.
	self assertPercentageOf: #element3 in: generation is: (distribution probabilityOf: #element3) within: tolerance
]

{ #category : #tests }
OverallOccurrenceDistributionTest >> testProbabilityOfGivenElementHasCorrectValue [
	| distribution |
	distribution := OverallOccurrenceDistribution
		with:
			{(IndividualOccurrenceProbability of: #element1 withProbability: 30).
			(IndividualOccurrenceProbability of: #element2 withProbability: 26).
			(IndividualOccurrenceProbability of: #element3 withProbability: 24).
			(IndividualOccurrenceProbability of: #element4 withProbability: 20)}.
	self assert: (distribution probabilityOf: #element1) equals: 30
]

{ #category : #tests }
OverallOccurrenceDistributionTest >> testTotalProbabilitiesCannotBeDifferentToOneHundred [
	self
		should: [ OverallOccurrenceDistribution
				with:
					{(IndividualOccurrenceProbability of: #element1 withProbability: 25).
					(IndividualOccurrenceProbability of: #element2 withProbability: 25)} ]
		raise: AssertionFailure.
	self
		should: [ OverallOccurrenceDistribution
				with:
					{(IndividualOccurrenceProbability of: #element1 withProbability: 80).
					(IndividualOccurrenceProbability of: #element3 withProbability: 25)} ]
		raise: AssertionFailure
]
