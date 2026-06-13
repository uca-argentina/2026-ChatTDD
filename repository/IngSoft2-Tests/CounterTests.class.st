Class {
	#name : 'CounterTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CounterTests >> test01WhenCounterIsCreatedItStartsAs0 [

	| counter |
	counter := Counter start.
	self assert: counter currentValue equals: 0.
]

{ #category : 'tests' }
CounterTests >> test02WhenCounterAddsThenItsValueIsOneMoreThanBefore [

	| counter |
	counter := Counter start.
	counter add.
	self assert: counter currentValue equals: 1.
]
