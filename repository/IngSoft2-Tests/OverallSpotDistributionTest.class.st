"
This class contains tests about overall spot distributions
"
Class {
	#name : #OverallSpotDistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OverallSpotDistributionTest >> testCantCreateEmptyDistribution [
	self
		should: [ OverallSpotDistribution with: {} ]
		raise: AssertionFailure
]

{ #category : #tests }
OverallSpotDistributionTest >> testCantHaveDupplicatedIndividualDistribution [
	self
		should: [ OverallSpotDistribution
				with:
					{(IndividualSpotDistribution of: Regular withProbability: 25).
					(IndividualSpotDistribution of: AtomicBomb withProbability: 25).
					(IndividualSpotDistribution of: Regular withProbability: 25)} ]
		raise: AssertionFailure
]

{ #category : #tests }
OverallSpotDistributionTest >> testDistributionYieldsExpectedProbabilityForEachSpot [
	| distribution distributionCounter |
	distributionCounter := Dictionary new.
	distributionCounter at: #Regular put: 0.
	distributionCounter at: #AtomicBomb put: 0.
	distributionCounter at: #SpeedUp put: 0.
	distributionCounter at: #MoonWalk put: 0.
	distribution := OverallSpotDistribution
		with:
			{(IndividualSpotDistribution of: Regular withProbability: 25).
			(IndividualSpotDistribution of: AtomicBomb withProbability: 25).
			(IndividualSpotDistribution of: SpeedUp withProbability: 25).
			(IndividualSpotDistribution of: MoonWalk withProbability: 25)}.
	100000
		timesRepeat: [ | currentValue |
			currentValue := distribution randomSpot class name.
			distributionCounter
				at: currentValue
				put: (distributionCounter at: currentValue) + 1 ].
	(distributionCounter collect: [ :each | each / 1000 roundTo: 1 ])
		do: [ :each | self assert: each equals: 25 ]
]

{ #category : #tests }
OverallSpotDistributionTest >> testProbabilitiesMustAddUpToAHundred [
	self
		should: [ OverallSpotDistribution
				with:
					{(IndividualSpotDistribution of: Regular withProbability: 25).
					(IndividualSpotDistribution of: AtomicBomb withProbability: 25).
					(IndividualSpotDistribution of: SpeedUp withProbability: 25)} ]
		raise: AssertionFailure.
	OverallSpotDistribution
		with:
			{(IndividualSpotDistribution of: Regular withProbability: 25).
			(IndividualSpotDistribution of: AtomicBomb withProbability: 25).
			(IndividualSpotDistribution of: SpeedUp withProbability: 25).
			(IndividualSpotDistribution of: MoonWalk withProbability: 25)}
]

{ #category : #tests }
OverallSpotDistributionTest >> testProbabilityOfGivenSpotHasCorrectValue [
	| distribution |
	distribution := OverallSpotDistribution
		with:
			{(IndividualSpotDistribution of: Regular withProbability: 25).
			(IndividualSpotDistribution of: AtomicBomb withProbability: 25).
			(IndividualSpotDistribution of: SpeedUp withProbability: 25).
			(IndividualSpotDistribution of: MoonWalk withProbability: 25)}.
	self assert: (distribution probabilityOf: Regular) equals: 25
]
