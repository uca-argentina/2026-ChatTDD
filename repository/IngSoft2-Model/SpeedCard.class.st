Class {
	#name : 'SpeedCard',
	#superclass : 'Object',
	#instVars : [
		'shipAffected'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpeedCard >> effect [
	^ 1.
]

{ #category : 'as yet unclassified' }
SpeedCard >> effectTo: aShip [
	shipAffected := aShip.
]

{ #category : 'as yet unclassified' }
SpeedCard >> effectTo: aShip among: allShips [ 
	shipAffected := aShip name.
	aShip effectBy: self.
]
