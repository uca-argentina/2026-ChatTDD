Class {
	#name : 'RepeatCard',
	#superclass : 'InstantCard',
	#instVars : [
		'name',
		'tile'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RepeatCard class >> usingCounter: counter [ 
	^(self new) initializeNameUsingCounter: counter.
]

{ #category : 'as yet unclassified' }
RepeatCard >> effectTo: ship among: ships [ 

	tile repeatEffectFor: ship
]

{ #category : 'initialization' }
RepeatCard >> initializeNameUsingCounter: counter [
	name := 'repeat', (counter add)asString.
	tile := nil.
]

{ #category : 'accessing' }
RepeatCard >> name [
	^ name
]

{ #category : 'accessing' }
RepeatCard >> target: lastTile [
	tile := lastTile.
]
