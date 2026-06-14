Class {
	#name : 'WormHoleTile',
	#superclass : 'Tile',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
WormHoleTile >> giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
    triggeringShip move: -4 limitedToSpaces: maxSize andLaps: laps.
]
