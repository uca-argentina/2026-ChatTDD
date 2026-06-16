Class {
	#name : 'HyperJumpTile',
	#superclass : 'Tile',
	#instVars : [
		'turnManager',
		'converter',
		'valueList',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperJumpTile class >> withParsecFactor: parsecPerTile and: values [
	^(self new) initializeWithParsecFactor: parsecPerTile and:values.
]

{ #category : 'private' }
HyperJumpTile >> currentValueToTile [
	| value |
	value:=(valueList at: turnManager current).
	^ converter convert:value first in:(value at:2) to:'Tiles'.
]

{ #category : 'execution' }
HyperJumpTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [
	board := aBoard .
	board moveShip: triggeringShip with:(self currentValueToTile).
	turnManager next.
]

{ #category : 'initialization' }
HyperJumpTile >> initializeWithParsecFactor: parsecPerTile and: values [
	converter:= UnitConverter withParsecFactor: parsecPerTile .
	valueList := values.
	turnManager := CircularIterator withTotalTurns: valueList size
	
]

{ #category : 'execution' }
HyperJumpTile >> repeatEffectFor: newTriggeringShip [

	self giveEffectTo: newTriggeringShip among: '' in: board 
]
