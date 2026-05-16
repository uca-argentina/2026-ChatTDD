Class {
	#name : 'MoonWalkTile',
	#superclass : 'Object',
	#instVars : [
		'amountBack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MoonWalkTile class >> withAmountBack: steps [ 
	 ^ self new initializeWithAmountBack: steps.
]

{ #category : 'as yet unclassified' }
MoonWalkTile >> giveEffectTo: triggeringShip among: allShips limitedTo: maxSize [
    (allShips reject: [ :ship | ship = triggeringShip ])
        do: [ :ship | ship move: amountBack negated limitedTo: maxSize ].
]

{ #category : 'initialization' }
MoonWalkTile >> initializeWithAmountBack: steps [ 
	amountBack := steps.
]
