Class {
	#name : 'BoardGenerator',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'execution' }
BoardGenerator >> generateTileWithParsecFactor: parsecFactor [
    | valor table |
    valor := 100 atRandom.
    table := {
        { 40.  [ BasicTile new ] }.
        { 60.  [ WormHoleTile new ] }.
        { 80.  [ SpeedUpTile new ] }.
        { 90.  [ MoonWalkTile withAmountBack: 10 atRandom ] }.
        { 98.  [ HyperJumpTile withParsecFactor: parsecFactor ] }.
        { 100. [ AtomicBombTile new ] }.
    }.
    ^ ((table detect: [ :entry | valor <= (entry at: 1) ]) at: 2) value
	
]
