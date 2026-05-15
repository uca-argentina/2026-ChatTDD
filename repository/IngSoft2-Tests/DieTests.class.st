Class {
	#name : 'DieTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DieTests >> test01WhenDieHasNSidesThenItShouldRollBetween1AndN [

	|aDie aRoll sides|
	 
	sides := 6.
   aDie := Die withSides: sides.
	aRoll := aDie roll.

	self assert: aRoll >= 1.
	self assert: aRoll <=sides.
]
