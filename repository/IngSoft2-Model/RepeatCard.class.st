Class {
	#name : 'RepeatCard',
	#superclass : 'InstantCard',
	#instVars : [
		'name'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RepeatCard class >> usingCounter: counter [ 
	^(self new) initializeNameUsingCounter: counter.
]

{ #category : 'as yet unclassified' }
RepeatCard >> effectTo: affectingShip among: ships inGame: game [ 
	game applyLastTileEffectFor: affectingShip.

]

{ #category : 'initialization' }
RepeatCard >> initializeNameUsingCounter: counter [
	name := 'repeat', (counter add)asString.
]

{ #category : 'accessing' }
RepeatCard >> name [ 
	^ name
]
