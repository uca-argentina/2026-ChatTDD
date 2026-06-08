Class {
	#name : 'CancellationCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CancellationCard >> effectTo: aShip among: allShips andCancel: aCard [ 
	(allShips anySatisfy: [ : ship | ship checkCard: aCard ]) ifFalse: [Error signal: 'Card isnt affecting this ship' ].
	allShips do: [ :ship | ship cancel: aCard ].
]
