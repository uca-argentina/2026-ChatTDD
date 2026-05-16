Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'lap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Ship class >> default [
	^ (self new) initializePosition.
]

{ #category : 'initialization' }
Ship >> initializePosition [
	position:= 0.
	lap:=0.
]

{ #category : 'as yet unclassified' }
Ship >> lap [
	^ lap
]

{ #category : 'as yet unclassified' }
Ship >> move: roll limitedToSpaces: maxPosition andToLaps: maxLaps [
	| positionCalc |
	positionCalc := position + roll.
	( positionCalc >= maxPosition) ifFalse: [ 
		position := position + roll ]
	ifTrue: [ 
		position := position + roll - maxPosition.
		lap := lap + 1
	].
]

{ #category : 'execution' }
Ship >> position [
	^ position .
]
