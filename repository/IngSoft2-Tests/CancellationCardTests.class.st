Class {
	#name : 'CancellationCardTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CancellationCardTests >> test01WhenFirstSpeedCardCardIsCreatedItsNameIsSpeed1 [

	| cancellation counter |
	counter := Counter start.
	cancellation := CancellationCard usingCounter: counter.
	self assert: cancellation name equals: 'cancellation1'.
]

{ #category : 'tests' }
CancellationCardTests >> test02WhenACardIsCreatedTheNameReflectsItsPositionAmongAllOtherSpeedCards [

	| cancellation counter cancellation2 cancellation3 |
	counter := Counter start.
	cancellation := CancellationCard usingCounter: counter.
	cancellation2 := CancellationCard usingCounter: counter.
	cancellation3 := CancellationCard usingCounter: counter.
	self assert: cancellation2 name equals: 'cancellation2'.
	self assert: cancellation3 name equals: 'cancellation3'.
]
