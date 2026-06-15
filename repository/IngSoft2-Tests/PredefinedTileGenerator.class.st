Class {
	#name : 'PredefinedTileGenerator',
	#superclass : 'Object',
	#instVars : [
		'turnManager',
		'tileTypes'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
PredefinedTileGenerator class >> withTileType: aTile [
	^ self new initializeWithTileTypes: {aTile}
]

{ #category : 'as yet unclassified' }
PredefinedTileGenerator class >> withTileTypes: tiles [
	^ self new initializeWithTileTypes: tiles
]

{ #category : 'as yet unclassified' }
PredefinedTileGenerator >> generateTileWithParsecFactor: parsecFactor [
	| tile |
	tile := tileTypes at: turnManager current.
	turnManager next.
	^ tile
]

{ #category : 'initialization' }
PredefinedTileGenerator >> initializeWithTileTypes: tiles [
	tileTypes := tiles asOrderedCollection.
	turnManager := CircularIterator withTotalTurns: tileTypes size.
]
