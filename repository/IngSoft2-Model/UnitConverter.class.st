Class {
	#name : 'UnitConverter',
	#superclass : 'Object',
	#instVars : [
		'conversions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
UnitConverter class >> withParsecFactor: parsecFactor [

	^ self new initializeWithParsecFactor: parsecFactor
]

{ #category : 'executing' }
UnitConverter >> convert: amount in: unit to: anotherUnit [
	| key rate |
	unit=anotherUnit ifTrue:[^amount].
	key:= unit,'->',anotherUnit.
	rate := conversions at: key ifAbsent: [ self error: 'Conversion no encontrada' ].
   ^(amount *rate) asInteger
]

{ #category : 'initialization' }
UnitConverter >> initializeWithParsecFactor: parsecFactor [
	conversions := Dictionary new.
	conversions at: 'Parsecs','->','Tiles' put:1/parsecFactor.
	conversions at: 'Tiles','->','Parsecs' put:parsecFactor.
	conversions at: 'Parsecs','->','Light years' put:3.
	conversions at: 'Light years','->','Parsecs' put:1/3.	
	conversions at: 'Tiles','->','Light years' put:parsecFactor*3.
	conversions at: 'Light years','->','Tiles' put:(1/3)*(1/parsecFactor).
]
