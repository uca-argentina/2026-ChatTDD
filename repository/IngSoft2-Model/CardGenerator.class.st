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

{ #category : 'executing' }
CardGenerator >> giveRandomCard [

	| number cards |
	number := 100 atRandom.
	cards := {
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
	^ ((cards detect: [ :value | number <= (value at: 1) ]) at: 2) value
]

{ #category : 'initialization' }
CardGenerator >> initialize [ 
	counters := { Counter start. Counter start. Counter start. Counter start. Counter start. Counter start. }

]
