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
CardTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [

	triggeringShip addToHand: cardGenerator giveRandomCard
]

{ #category : 'initialization' }
CardTile >> initializeCardTile [

	cardGenerator := CardGenerator new
]
