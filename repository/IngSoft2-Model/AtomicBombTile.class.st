Class {
	#name : 'AtomicBombTile',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBombTile >> giveEffectTo: triggeringShip among: allShips limitedTo: maxSize [
   allShips
       do: [ :ship | ship move: ship position negated limitedTo: maxSize ].
]
