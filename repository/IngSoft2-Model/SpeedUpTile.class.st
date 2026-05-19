Class {
	#name : 'SpeedUpTile',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpeedUpTile >> giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
    triggeringShip move: 4 limitedToSpaces: maxSize andLaps: laps.
]

{ #category : 'as yet unclassified' }
SpeedUpTile >> tile [
 ^self
]
