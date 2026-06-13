Class {
	#name : 'CardGenerator',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardGenerator >> giveRandomCard [

	| tmp1 tmp2 |
	tmp1 := 100 atRandom.
	tmp2 := {
		        {
			        25.
			        [ OverloadCard new ] }.
		        {
			        50.
			        [ SpeedCard new ] }.
		        {
			        75.
			        [ AccelerationCard new ] }.
		        {
			        100.
			        [ CancellationCard new ] } }.
	^ ((tmp2 detect: [ :arg1 | tmp1 <= (arg1 at: 1) ]) at: 2) value
]
