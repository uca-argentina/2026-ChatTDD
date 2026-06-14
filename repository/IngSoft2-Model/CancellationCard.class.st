Class {
	#name : 'CancellationCard',
	#superclass : 'InstantCard',
	#instVars : [
		'name',
		'target'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CancellationCard class >> usingCounter: counter [ 
	^(self new) initializeNameUsingCounter: counter.
]

{ #category : 'as yet unclassified' }
CancellationCard >> effectTo: aShip among: ships [ 

	| affected |
	affected := ships select: [ :ship | ship checkCard: target ].
	
	affected do: [ :ship | ship cancel: target ]
]

{ #category : 'initialization' }
CancellationCard >> initializeNameUsingCounter: counter [
	name := 'cancellation', (counter add)asString.
]

{ #category : 'accessing' }
CancellationCard >> name [
	^ name.
]

{ #category : 'class management' }
CancellationCard >> rename: newName [
	name := newName.
]

{ #category : 'accessing' }
CancellationCard >> target: targetCardName [ 
	target:= targetCardName.
]
