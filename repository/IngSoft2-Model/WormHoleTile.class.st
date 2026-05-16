Class {
	#name : 'WormHoleTile',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
WormHoleTile >> giveEffectTo: triggeringShip among: allShips limitedTo: maxSize [
    triggeringShip move: -4 limitedTo: maxSize.
]
