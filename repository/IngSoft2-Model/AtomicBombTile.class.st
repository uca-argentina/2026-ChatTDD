Class {
	#name : 'AtomicBombTile',
	#superclass : 'Tile',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
AtomicBombTile >> giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
   allShips
       do: [ :ship | ship resetToStartOfLap ].
]

{ #category : 'as yet unclassified' }
AtomicBombTile >> repeatEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
	triggeringShip resetToStartOfLap.
]
