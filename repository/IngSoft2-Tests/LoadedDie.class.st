Class {
	#name : 'LoadedDie',
	#superclass : 'Object',
	#instVars : [
		'dieRolls',
		'turnManager'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
LoadedDie class >> thatRolls: rolls [
	^(self new)initializeRolls: rolls.
]

{ #category : 'initialization' }
LoadedDie >> initializeRolls: rolls [
	dieRolls := rolls.
	turnManager := CircularIterator withTotalTurns: dieRolls size
]

{ #category : 'execution' }
LoadedDie >> roll [

	| result |
	result := dieRolls at: turnManager current.
	turnManager next.
	^result
]
