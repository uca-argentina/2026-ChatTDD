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

{ #category : 'tests' }
DieTests >> test02WhenDieSidesAreLessThan2ThenDieIsNotCreated [

	| aDie |

	self
		should: [
		aDie := Die withSides: -1]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A die must have at least 2 sides' ]
]
