Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'currentLap',
		'absPosition',
		'lapPosition',
		'name',
		'hand'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Ship class >> withName: arg1 [

	^ self new initializeWithName: arg1
]

{ #category : 'adding' }
Ship >> addToHand: aCard [ 
	hand add: aCard.
]

{ #category : 'accessing' }
Ship >> currentLap [

	^ currentLap
]

{ #category : 'accessing' }
Ship >> hand [
	^ hand.
]

{ #category : 'initialization' }
Ship >> initializeWithName: arg1 [

	name := arg1.
	absPosition := 1.
	lapPosition := 1.
	currentLap := 1.
	hand := OrderedCollection new.
]

{ #category : 'execution' }
Ship >> lapPosition [

	^ lapPosition
]

{ #category : 'execution' }
Ship >> move: arg1 limitedToSpaces: arg2 andLaps: arg3 [

	absPosition := absPosition + arg1 min: arg2 * arg3 max: 1.
	self
		setCurrentLap: arg2;
		setLapPosition: arg2
]

{ #category : 'accessing' }
Ship >> name [

	^ name
]

{ #category : 'execution' }
Ship >> resetToStartOfLap [

	lapPosition := 1
]

{ #category : 'initialization' }
Ship >> setCurrentLap: arg1 [

	currentLap := absPosition - 1 // arg1 + 1
]

{ #category : 'initialization' }
Ship >> setLapPosition: arg1 [

	lapPosition := absPosition - 1 \\ arg1 + 1
]

{ #category : 'as yet unclassified' }
Ship >> useCard: aCard [ 
	hand remove: aCard.
]
