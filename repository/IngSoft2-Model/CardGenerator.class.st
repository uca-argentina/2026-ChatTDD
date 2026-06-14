Class {
	#name : 'CardGenerator',
	#superclass : 'Object',
	#instVars : [
		'counters'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
CardGenerator class >> default [
^(self new) initialize.
]

{ #category : 'as yet unclassified' }
CardGenerator >> giveRandomCard [

	| tmp1 tmp2 |
	tmp1 := 100 atRandom.
	tmp2 := {
		        {
			        17.
			        [ OverloadCard usingCounter: (counters at: 1) ] }.
		        {
			        34.
			        [ SpeedCard usingCounter: (counters at: 2) ] }.
		        {
			        50.
			        [ AccelerationCard usingCounter: (counters at: 3) ] }.
		        {
			        67.
			        [ CancellationCard usingCounter: (counters at: 4) ] }.
		        {
			        84.
			        [ RedoCard usingCounter: (counters at: 5) ] }.
		        {
			        100.
			        [ RepeatCard usingCounter: (counters at: 6) ] } }.
	^ ((tmp2 detect: [ :arg1 | tmp1 <= (arg1 at: 1) ]) at: 2) value
]

{ #category : 'initialization' }
CardGenerator >> initialize [ 
	counters := { Counter start. Counter start. Counter start. Counter start. Counter start. Counter start. }

]
