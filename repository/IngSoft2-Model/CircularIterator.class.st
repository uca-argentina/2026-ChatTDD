Class {
	#name : 'CircularIterator',
	#superclass : 'Object',
	#instVars : [
		'size',
		'current'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
CircularIterator class >> withTotalTurns: totalTurns [
	^(self new) initializeWithSize: totalTurns 
	
]

{ #category : 'accessing' }
CircularIterator >> current [
^current 
]

{ #category : 'accessing' }
CircularIterator >> currentMatches: shipsTurn [ 
	^ self current = shipsTurn .
]

{ #category : 'initialization' }
CircularIterator >> initializeWithSize: totalSize [
	size:= totalSize .
	current:= 1
]

{ #category : 'execution' }
CircularIterator >> next [
	current:= current\\ size + 1.
]
