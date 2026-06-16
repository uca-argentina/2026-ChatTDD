Class {
	#name : 'NoEffectTile',
	#superclass : 'Tile',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
NoEffectTile >> giveEffectTo: triggeringShip among: allShips in: aBoard [
	
]

{ #category : 'execution' }
NoEffectTile >> repeatEffectFor: newTriggeringCard [
	self giveEffectTo: '' among: '' in: ''. 
]
