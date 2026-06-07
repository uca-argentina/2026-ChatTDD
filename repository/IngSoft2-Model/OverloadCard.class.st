Class {
	#name : 'OverloadCard',
	#superclass : 'Object',
	#instVars : [
		'shipAffected'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
OverloadCard >> effect [
	^ (-2).
]

{ #category : 'as yet unclassified' }
OverloadCard >> effectTo: aShip [
	shipAffected := aShip.
]

{ #category : 'as yet unclassified' }
OverloadCard >> effectTo: aShip among: allShips [ 
	shipAffected := aShip name.
	aShip effectBy: self.
]
