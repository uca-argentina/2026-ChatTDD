Class {
	#name : 'AtomicBombTile',
	#superclass : 'Tile',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
AtomicBombTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [
   allShips
       do: [ :ship | aBoard moveShip: ship with: ((aBoard lapPosition: ship) -1)negated  ].
]
