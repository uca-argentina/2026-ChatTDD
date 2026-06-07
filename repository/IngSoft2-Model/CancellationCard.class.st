Class {
	#name : 'CancellationCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CancellationCard >> effectTo: aShip among: allShips andCancel: aCard [ 
	aShip cancel: aCard.
]
