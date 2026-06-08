Class {
	#name : 'CardGenerator',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardGenerator >> giveRandomCard [
	| value table |
    value := 100 atRandom.
    table := {
        { 25.  [ OverloadCard new ] }.
        { 50.  [ SpeedCard new ] }.
        { 75.  [ AccelerationCard new ] }.
        { 100.  [ CancellationCard new ] }.
    }.
    ^ ((table detect: [ :entry | value <= (entry at: 1) ]) at: 2) value
]
