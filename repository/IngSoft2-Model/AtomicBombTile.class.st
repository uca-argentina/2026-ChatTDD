Class {
	#name : 'AtomicBombTile',
	#superclass : 'Tile',
	#instVars : [
		'ships',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
AtomicBombTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [
	ships := allShips.
	board := aBoard.
   ships 
       do: [ :ship | board moveShip: ship with: ((board lapPosition: ship) -1)negated  ].
]

{ #category : 'executing' }
AtomicBombTile >> repeatEffectFor: newTriggeringShip [
	self giveEffectTo: newTriggeringShip among: ships in: board . 
]
