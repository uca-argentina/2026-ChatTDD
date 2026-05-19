Class {
	#name : 'BoardConstructor',
	#superclass : 'Object',
	#instVars : [
		'parsecFactor',
		'amountBack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BoardConstructor class >> withMoonWalkAmountBack: steps andParsecFactor: parsecPerTile [
	 ^ self new withMoonWalkAmountBack: steps andParsecFactor:parsecPerTile.
]

{ #category : 'as yet unclassified' }
BoardConstructor >> tile [
    | valor table |
    valor := 100 atRandom.
    table := {
        { 40.  [ BasicTile new ] }.
        { 60.  [ WormHoleTile new ] }.
        { 80.  [ SpeedUpTile new ] }.
        { 90.  [ MoonWalkTile withAmountBack: amountBack ] }.
        { 98.  [ HyperJumpTile withParsecFactor: parsecFactor ] }.
        { 100. [ AtomicBombTile new ] }.
    }.
    ^ ((table detect: [ :entry | valor <= (entry at: 1) ]) at: 2) value
	
]

{ #category : 'as yet unclassified' }
BoardConstructor >> withMoonWalkAmountBack: steps andParsecFactor: parsecPerTile [
	parsecFactor:= parsecPerTile.
	amountBack:= steps 
]
