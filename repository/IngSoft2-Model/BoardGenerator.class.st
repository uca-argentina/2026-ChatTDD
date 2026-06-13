Class {
	#name : 'BoardGenerator',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BoardGenerator >> generateHyperJumpValues [
    | units size |
    units := #('Parsecs' 'Light years').
    size := (2 + 5 atRandom).
    ^ (1 to: size) collect: [ :each |
        { (10 + 90 atRandom).
          (units at: units size atRandom) }
    ]
]

{ #category : 'execution' }
BoardGenerator >> generateTileWithParsecFactor: arg1 [

	| tmp1 tmp2 |
	tmp1 := 100 atRandom.
	tmp2 := {
		        {
			        30.
			        [ BasicTile new ] }.
		        {
			        40.
			        [ CardTile new ] }.
		        {
			        60.
			        [ WormHoleTile new ] }.
		        {
			        80.
			        [ SpeedUpTile new ] }.
		        {
			        90.
			        [ MoonWalkTile withAmountBack: 10 atRandom ] }.
		        {
			        98.
			        [ HyperJumpTile withParsecFactor: arg1 and: self generateHyperJumpValues ] }.
		        {
			        100.
			        [ AtomicBombTile new ] } }.
	^ ((tmp2 detect: [ :arg2 | tmp1 <= (arg2 at: 1) ]) at: 2) value
]
