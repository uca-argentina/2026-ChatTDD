Class {
	#name : 'CardTile',
	#superclass : 'Tile',
	#instVars : [
		'cardGenerator'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
CardTile class >> default [

	^ self new initializeCardTile
]

{ #category : 'as yet unclassified' }
CardTile >> giveEffectTo: arg1 among: arg2 limitedToSpaces: arg3 andLaps: arg4 [

	arg1 addToHand: cardGenerator giveRandomCard
]

{ #category : 'initialization' }
CardTile >> initializeCardTile [

	cardGenerator := CardGenerator new
]
