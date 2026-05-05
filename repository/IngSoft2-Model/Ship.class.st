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

{ #category : 'accessing' }
Ship >> fixPosition: totalSpaces [
	(position > totalSpaces) ifTrue: [position := totalSpaces ].
]

{ #category : 'as yet unclassified' }
Ship >> givePosition [
	^ position .
]

{ #category : 'testing' }
Ship >> hasCrossed: finishLine [
	^ (position >= finishLine).
]

{ #category : 'initialization' }
Ship >> initializePosition [
	position:= 0.
]

{ #category : 'accessing' }
Ship >> move: roll [ 
	position := position + roll.
]
