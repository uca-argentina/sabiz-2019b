"
This class contains tests about overall spot distributions
"
Class {
	#name : #OverallEffectDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OverallEffectDistributionTest >> testCantCreateEmptyDistribution [
	self
		should: [ OverallEffectDistribution with: {} ]
		raise: AssertionFailure
]

{ #category : #tests }
OverallEffectDistributionTest >> testCantHaveDupplicatedIndividualDistribution [
	self
		should: [ OverallEffectDistribution
				with:
					{(IndividualEffectProbability of: Regular withProbability: 25).
					(IndividualEffectProbability of: AtomicBomb withProbability: 25).
					(IndividualEffectProbability of: Regular withProbability: 25)} ]
		raise: AssertionFailure
]

{ #category : #tests }
OverallEffectDistributionTest >> testDistributionYieldsExpectedProbabilityForEachSpot [
	| distribution distributionCounter |
	distributionCounter := Dictionary new.
	distributionCounter at: #Regular put: 0.
	distributionCounter at: #AtomicBomb put: 0.
	distributionCounter at: #SpeedUp put: 0.
	distributionCounter at: #MoonWalk put: 0.
	distribution := OverallEffectDistribution
		with:
			{(IndividualEffectProbability of: Regular withProbability: 25).
			(IndividualEffectProbability of: AtomicBomb withProbability: 25).
			(IndividualEffectProbability of: SpeedUp withProbability: 25).
			(IndividualEffectProbability of: MoonWalk withProbability: 25)}.
	10000
		timesRepeat: [ | currentValue |
			currentValue := distribution spotWithRandomEffect effect class name.
			distributionCounter
				at: currentValue
				put: (distributionCounter at: currentValue) + 1 ].
	(distributionCounter collect: [ :each | each / 100 roundTo: 1 ])
		do: [ :each | self assert: (each - 25) abs <= 1 ]
]

{ #category : #tests }
OverallEffectDistributionTest >> testProbabilitiesMustAddUpToAHundred [
	self
		should: [ OverallEffectDistribution
				with:
					{(IndividualEffectProbability of: Regular withProbability: 25).
					(IndividualEffectProbability of: AtomicBomb withProbability: 25).
					(IndividualEffectProbability of: SpeedUp withProbability: 25)} ]
		raise: AssertionFailure.
	OverallEffectDistribution
		with:
			{(IndividualEffectProbability of: Regular withProbability: 25).
			(IndividualEffectProbability of: AtomicBomb withProbability: 25).
			(IndividualEffectProbability of: SpeedUp withProbability: 25).
			(IndividualEffectProbability of: MoonWalk withProbability: 25)}
]

{ #category : #tests }
OverallEffectDistributionTest >> testProbabilityOfGivenSpotHasCorrectValue [
	| distribution |
	distribution := OverallEffectDistribution
		with:
			{(IndividualEffectProbability of: Regular withProbability: 25).
			(IndividualEffectProbability of: AtomicBomb withProbability: 25).
			(IndividualEffectProbability of: SpeedUp withProbability: 25).
			(IndividualEffectProbability of: MoonWalk withProbability: 25)}.
	self assert: (distribution probabilityOf: Regular) equals: 25
]
