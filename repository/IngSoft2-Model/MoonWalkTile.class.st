Class {
	#name : 'MoonWalkTile',
	#superclass : 'Tile',
	#instVars : [
		'amountBack',
		'ships',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MoonWalkTile class >> withAmountBack: arg1 [

	^ self new initializeWithAmountBack: arg1
]

{ #category : 'execution' }
MoonWalkTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [

	ships := allShips.
	board := aBoard.
	(ships reject: [ :ship | ship = triggeringShip ]) do: [ :ship |
		board moveShip: ship with: amountBack negated ]
]

{ #category : 'initialization' }
MoonWalkTile >> initializeWithAmountBack: arg1 [

	amountBack := arg1
]

{ #category : 'as yet unclassified' }
MoonWalkTile >> repeatEffectFor: newTriggeringShip [

	self giveEffectTo: newTriggeringShip among: ships in: board 
]
