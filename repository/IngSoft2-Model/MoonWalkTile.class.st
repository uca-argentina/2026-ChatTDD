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

{ #category : 'initialization' }
MoonWalkTile class >> withAmountBack: number [

	^ self new initializeWithAmountBack: number
]

{ #category : 'execution' }
MoonWalkTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [

	ships := allShips.
	board := aBoard.
	(ships reject: [ :ship | ship = triggeringShip ]) do: [ :ship |
		board moveShip: ship with: amountBack negated ]
]

{ #category : 'initialization' }
MoonWalkTile >> initializeWithAmountBack: number [

	amountBack := number
]

{ #category : 'execution' }
MoonWalkTile >> repeatEffectFor: newTriggeringShip [

	self giveEffectTo: newTriggeringShip among: ships in: board 
]
