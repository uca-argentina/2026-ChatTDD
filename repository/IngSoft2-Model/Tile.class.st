Class {
	#name : 'Tile',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Tile >> giveEffectTo: triggeringShip among: allShips in: aBoard [
	self subclassResponsibility 
]
