"
This class contains tests about overall spot distributions
"
Class {
	#name : #OverallOccurrenceDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OverallOccurrenceDistributionTest >> testCantCreateEmptyDistribution [
	self
		should: [ OverallOccurrenceDistribution with: {} ]
		raise: AssertionFailure
]

{ #category : #tests }
OverallOccurrenceDistributionTest >> testDistributionYieldsExpectedProbabilityForEachElement [
	| distribution distributionCounter |
	distributionCounter := Dictionary new.
	distributionCounter at: #NullEffect put: 0.
	distributionCounter at: #AtomicBombEffect put: 0.
	distributionCounter at: #SpeedUpEffect put: 0.
	distributionCounter at: #MoonWalkEffect put: 0.
	distribution := OverallOccurrenceDistribution
		with:
			{(IndividualOccurrenceProbability of: #NullEffect withProbability: 25).
			(IndividualOccurrenceProbability
				of: #AtomicBombEffect
				withProbability: 25).
			(IndividualOccurrenceProbability of: #SpeedUpEffect withProbability: 25).
			(IndividualOccurrenceProbability of: #MoonWalkEffect withProbability: 25)}.
	10000
		timesRepeat: [ | currentValue |
			currentValue := distribution random.
			distributionCounter
				at: currentValue
				put: (distributionCounter at: currentValue) + 1 ].
	(distributionCounter associations
		collect:
			[ :each | Association key: each key value: (each value / 100 roundTo: 1) ])
		do: [ :each | 
			self
				assert: (each value - (distribution probabilityOf: each key)) abs <= 1 ]
]

{ #category : #tests }
OverallOccurrenceDistributionTest >> testProbabilityOfGivenElementHasCorrectValue [
	| distribution |
	distribution := OverallOccurrenceDistribution
		with:
			{(IndividualOccurrenceProbability of: #NullEffect withProbability: 25).
			(IndividualOccurrenceProbability of: #AtomicBombEffect withProbability: 25).
			(IndividualOccurrenceProbability of: #SpeedUpEffect withProbability: 25).
			(IndividualOccurrenceProbability of: #MoonWalkEffect withProbability: 25)}.
	self assert: (distribution probabilityOf: #NullEffect) equals: 25
]

{ #category : #tests }
OverallOccurrenceDistributionTest >> testTotalProbabilitiesCannotBeLowerThanOneHundred [
	self
		should: [ OverallOccurrenceDistribution
				with:
					{(IndividualOccurrenceProbability of: NullEffect new withProbability: 25).
					(IndividualOccurrenceProbability of: AtomicBombEffect new withProbability: 25).
					(IndividualOccurrenceProbability of: WormHoleEffect new withProbability: 25)} ]
		raise: AssertionFailure
]
