Class {
	#name : 'HardcodedBoardGenerator',
	#superclass : 'Object',
	#instVars : [
		'turnManager',
		'tileTypes'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
HardcodedBoardGenerator class >> withTileType: aTile [
	^ self new initializeWithTileTypes: {aTile}
]

{ #category : 'as yet unclassified' }
HardcodedBoardGenerator class >> withTileTypes: tiles [
	^ self new initializeWithTileTypes: tiles
]

{ #category : 'as yet unclassified' }
HardcodedBoardGenerator >> generateTileWithParsecFactor: parsecFactor [
	| tile |
	tile := tileTypes at: turnManager currentTurn.
	turnManager changeTurn.
	^ tile
]

{ #category : 'initialization' }
HardcodedBoardGenerator >> initializeWithTileTypes: tiles [
	tileTypes := tiles asOrderedCollection.
	turnManager := TurnManager withTotalTurns: tileTypes size.
]
