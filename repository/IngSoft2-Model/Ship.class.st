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

{ #category : 'initialization' }
Ship >> initializePosition [
	position:= 0.
]

{ #category : 'execution' }
Ship >> move: roll limitedTo: maxPosition [
    position := (position + roll) min: maxPosition.
]

{ #category : 'execution' }
Ship >> position [
	^ position .
]
