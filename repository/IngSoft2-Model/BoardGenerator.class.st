Class {
	#name : 'BoardGenerator',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

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
			        [ HyperJumpTile withParsecFactor: arg1 ] }.
		        {
			        100.
			        [ AtomicBombTile new ] } }.
	^ ((tmp2 detect: [ :arg2 | tmp1 <= (arg2 at: 1) ]) at: 2) value
]
