Class {
	#name : 'Tile',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'executing' }
Tile >> giveEffectTo: triggeringShip among: allShips in: aBoard [
	self subclassResponsibility 
]
