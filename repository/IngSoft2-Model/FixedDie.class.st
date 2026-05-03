Class {
	#name : 'FixedDie',
	#superclass : 'Object',
	#instVars : [
		'dieRolls',
		'player'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
FixedDie class >> thatRolls: rolls [
	^(self new)initializeRolls: rolls.
]

{ #category : 'initialization' }
FixedDie >> initializeRolls: rolls [
	dieRolls := rolls.
	player:=1.
]

{ #category : 'as yet unclassified' }
FixedDie >> roll [

	| result |
	result := dieRolls at: player.
	player := player \\ dieRolls size + 1.
	^result
]
