Class {
	#name : 'TileGenerator',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'executing' }
TileGenerator >> generateHyperJumpValues [
    | units size |
    units := #('Parsecs' 'Light years').
    size := 2 + (5 atRandom).
    ^ (1 to: size) collect: [ :each |
        { (10 + 90 atRandom).
          (units atRandom) }
    ]
]

{ #category : 'execution' }
TileGenerator >> generateTileWithParsecFactor: parsecsFactor andChances: chances [

	| number tiles |
	number := chances sum atRandom.
	tiles := {
		        {
			        chances first.
			        [ NoEffectTile new ] }.
		        {
			        (chances first: 2) sum.
			        [ CardTile default ] }.
		        {
			        (chances first: 3) sum.
			        [ WormHoleTile new ] }.
		        {
			        (chances first: 4) sum.
			        [ SpeedUpTile new ] }.
		        {
			        (chances first:5) sum.
			        [ MoonWalkTile withAmountBack: 10 atRandom ] }.
		        {
			        (chances first:6) sum.
			        [ HyperJumpTile withParsecFactor: parsecsFactor and: self generateHyperJumpValues ] }.
		        {
			        (chances first:7) sum.
			        [ AtomicBombTile new ] } }.
	^ ((tiles detect: [ :value | number <= (value at: 1) ]) at: 2) value
]

{ #category : 'private' }
TileGenerator >> generateTileWithParsecFactor: parsecsFactor andChances: chances andNumber: number [

	| tiles |
	tiles := {
		        {
			        chances first.
			        [ NoEffectTile new ] }.
		        {
			        (chances first: 2) sum.
			        [ CardTile default ] }.
		        {
			        (chances first: 3) sum.
			        [ WormHoleTile new ] }.
		        {
			        (chances first: 4) sum.
			        [ SpeedUpTile new ] }.
		        {
			        (chances first:5) sum.
			        [ MoonWalkTile withAmountBack: 10 atRandom ] }.
		        {
			        (chances first:6) sum.
			        [ HyperJumpTile withParsecFactor: parsecsFactor and: self generateHyperJumpValues ] }.
		        {
			        (chances first:7) sum.
			        [ AtomicBombTile new ] } }.
	^ ((tiles detect: [ :value | number <= (value at: 1) ]) at: 2) value
]
