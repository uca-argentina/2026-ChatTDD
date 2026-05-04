Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'sides'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Die class >> default [
	^ (self new) initializeSides: 6
]

{ #category : 'as yet unclassified' }
Die class >> withSides: amountOfSides [ 
	^ (self new) initializeSides: amountOfSides
]

{ #category : 'initialization' }
Die >> initializeSides: amountOfSides [
	sides := amountOfSides.
]

{ #category : 'as yet unclassified' }
Die >> roll [
	^ sides atRandom.
]
