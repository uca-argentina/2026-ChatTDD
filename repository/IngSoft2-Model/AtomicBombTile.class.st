Class {
	#name : 'AtomicBombTile',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBombTile >> giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
   allShips
       do: [ :ship | ship move: (ship lapPosition - 1) negated limitedToSpaces: maxSize andLaps: laps ].
]
