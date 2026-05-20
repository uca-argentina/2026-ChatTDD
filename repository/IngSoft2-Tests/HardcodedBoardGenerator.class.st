Class {
	#name : 'HardcodedBoardGenerator',
	#superclass : 'Object',
	#instVars : [
		'tileType'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
HardcodedBoardGenerator class >> withTileType: aTile [
	^ self new initializeWithTileType: aTile
]

{ #category : 'as yet unclassified' }
HardcodedBoardGenerator >> generateTileWithParsecFactor: parsecFactor [
	^ tileType.
]

{ #category : 'initialization' }
HardcodedBoardGenerator >> initializeWithTileType: aTile [
	tileType := aTile.
]
