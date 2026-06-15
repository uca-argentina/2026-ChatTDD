Class {
	#name : 'SpeedUpTile',
	#superclass : 'Tile',
	#instVars : [
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
SpeedUpTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [
	board := aBoard .
   board moveShip: triggeringShip with: 4
]

{ #category : 'execution' }
SpeedUpTile >> repeatEffectFor: newTriggeringShip [

self giveEffectTo: newTriggeringShip among: '' in: board.
]
