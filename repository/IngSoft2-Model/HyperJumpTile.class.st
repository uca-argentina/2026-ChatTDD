Class {
	#name : 'HyperJumpTile',
	#superclass : 'Tile',
	#instVars : [
		'parsecs',
		'parsecFactor',
		'turnManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJumpTile class >> withParsecFactor: parsecPerTile [
	^(self new) initializeWithParsecFactor: parsecPerTile .
]

{ #category : 'execution' }
HyperJumpTile >> giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
	triggeringShip move: (self parsecToTile) limitedToSpaces: maxSize andLaps: laps.
	turnManager changeTurn.
]

{ #category : 'initialization' }
HyperJumpTile >> initializeWithParsecFactor: parsecPerTile [
	parsecFactor:= parsecPerTile.
	parsecs := { 80. 50. 20 }.
	turnManager := TurnManager withTotalTurns: parsecs size
]

{ #category : 'private' }
HyperJumpTile >> parsecToTile [
	^ (parsecs at: turnManager currentTurn) // parsecFactor.
]

{ #category : 'as yet unclassified' }
HyperJumpTile >> repeatEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
	self giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps
]
