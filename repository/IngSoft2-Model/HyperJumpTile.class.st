Class {
	#name : 'HyperJumpTile',
	#superclass : 'Object',
	#instVars : [
		'parsec',
		'jumpDistances',
		'currentJump'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
HyperJumpTile class >> default [
	^self new initializeParsecs .
]

{ #category : 'as yet unclassified' }
HyperJumpTile >> giveEffectTo: triggeringShip among: aCollection limitedTo: maxSize [ 
	triggeringShip move: ((jumpDistances at: currentJump) * parsec) limitedTo: maxSize.
	currentJump := currentJump \\ jumpDistances size + 1
]

{ #category : 'initialization' }
HyperJumpTile >> initializeParsecs [

parsec :=2.
jumpDistances := { 3. 2. 1 }.
currentJump := 1.
]
