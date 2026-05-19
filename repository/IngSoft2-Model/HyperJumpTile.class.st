Class {
	#name : 'HyperJumpTile',
	#superclass : 'Object',
	#instVars : [
		'parsecs',
		'currentParsecsIndex',
		'parsecFactor'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
HyperJumpTile class >> default [
	^self new initializeParsecs .
]

{ #category : 'as yet unclassified' }
HyperJumpTile class >> withParsecFactor: parsecPerTile [
	^(self new) initializeWithParsecFactor: parsecPerTile .
]

{ #category : 'as yet unclassified' }
HyperJumpTile >> giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [
	triggeringShip move: (self parsecToTile) limitedToSpaces: maxSize andLaps: laps.
	currentParsecsIndex := currentParsecsIndex \\ parsecs size + 1
]

{ #category : 'initialization' }
HyperJumpTile >> initializeWithParsecFactor: parsecPerTile [
	parsecFactor:= parsecPerTile.
	parsecs := { 80. 50. 20 }.
	currentParsecsIndex := 1.
]

{ #category : 'as yet unclassified' }
HyperJumpTile >> parsecToTile [
	^ (parsecs at: currentParsecsIndex) // parsecFactor.
]

{ #category : 'as yet unclassified' }
HyperJumpTile >> tile [
 ^self
]
