Class {
	#name : 'WormHoleTile',
	#superclass : 'Tile',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
WormHoleTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [
    aBoard moveShip: triggeringShip with: -4
]
