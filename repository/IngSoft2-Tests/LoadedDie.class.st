Class {
	#name : 'LoadedDie',
	#superclass : 'Object',
	#instVars : [
		'dieRolls',
		'player'
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
	player:=1.
]

{ #category : 'execution' }
LoadedDie >> roll [

	| result |
	result := dieRolls at: player.
	player := player \\ dieRolls size + 1.
	^result
]
