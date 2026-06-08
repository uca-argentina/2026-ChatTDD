Class {
	#name : 'AccelerationCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'shipAffected'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AccelerationCard >> effect [
	^ 1.
]

{ #category : 'as yet unclassified' }
AccelerationCard >> effectTo: aShip among: allShips [ 
	shipAffected := 'all'.
	allShips do: [:ship | ship effectBy: self].
]
