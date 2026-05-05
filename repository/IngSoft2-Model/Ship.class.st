Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Ship class >> default [
	^ (self new) initializePosition.
]

{ #category : 'execution' }
Ship >> fixPosition: totalSpaces [
	(position > totalSpaces) ifTrue: [position := totalSpaces ].
]

{ #category : 'execution' }
Ship >> givePosition [
	^ position .
]

{ #category : 'execution' }
Ship >> hasCrossed: finishLine [
	^ (position >= finishLine).
]

{ #category : 'initialization' }
Ship >> initializePosition [
	position:= 0.
]

{ #category : 'execution' }
Ship >> move: roll [ 
	position := position + roll.
]
