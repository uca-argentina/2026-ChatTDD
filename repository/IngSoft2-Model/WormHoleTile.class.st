Class {
	#name : 'WormHoleTile',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
WormHoleTile >> giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
    triggeringShip move: -4 limitedToSpaces: maxSize andLaps: laps.
]
