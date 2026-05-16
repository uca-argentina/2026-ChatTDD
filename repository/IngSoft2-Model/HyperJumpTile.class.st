Class {
	#name : 'HyperJumpTile',
	#superclass : 'Object',
	#instVars : [
		'parsec'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
HyperJumpTile class >> default [
	^self new initializeParsecs .
]

{ #category : 'as yet unclassified' }
HyperJumpTile >> giveEffectTo: triggeringShip among: allShips limitedTo: maxSize [
    triggeringShip move: 3 * parsec limitedTo: maxSize.
]

{ #category : 'initialization' }
HyperJumpTile >> initializeParsecs [

parsec :=2.
]
