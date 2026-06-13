Class {
	#name : 'MoonWalkTile',
	#superclass : 'Tile',
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

{ #category : 'execution' }
MoonWalkTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [
    (allShips reject: [ :ship | ship = triggeringShip ])
        do: [ :ship | aBoard moveShip: ship with: amountBack negated ].
]

{ #category : 'initialization' }
MoonWalkTile >> initializeWithAmountBack: steps [ 
	amountBack := steps.
]
