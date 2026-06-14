Class {
	#name : 'BasicTile',
	#superclass : 'Tile',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
BasicTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [
	
]

{ #category : 'as yet unclassified' }
BasicTile >> repeatEffectFor: newTriggeringCard [
	self giveEffectTo: '' among: '' in: ''. 
]
