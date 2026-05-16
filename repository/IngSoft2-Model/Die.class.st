Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'sides'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Die class >> withSides: amountOfSides [
    amountOfSides < 2 ifTrue: [ Error signal: 'A die must have at least 2 sides' ].
    ^ self new initializeSides: amountOfSides
]

{ #category : 'initialization' }
Die >> initializeSides: amountOfSides [
	sides := amountOfSides.
]

{ #category : 'execution' }
Die >> roll [
	^ sides atRandom.
]
