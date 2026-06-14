Class {
	#name : 'SpeedUpTile',
	#superclass : 'Tile',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
SpeedUpTile >> giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
    triggeringShip move: 4 limitedToSpaces: maxSize andLaps: laps.
]

{ #category : 'as yet unclassified' }
SpeedUpTile >> repeatEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
	self giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps
]
