Class {
	#name : 'AccelerationCardTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AccelerationCardTests >> test01WhenFirstAccelerationCardCardIsCreatedItsNameIsAcceleration1 [

	| acceleration counter |
	counter := Counter start.
	acceleration := AccelerationCard usingCounter: counter.
	self assert: acceleration name equals: 'acceleration1'.
]

{ #category : 'tests' }
AccelerationCardTests >> test02WhenFirstAccelerationCardCardIsCreatedItsNameIsAcceleration1 [

	| acceleration counter acceleration2 acceleration3 |
	counter := Counter start.
	acceleration := AccelerationCard usingCounter: counter.
	acceleration2 := AccelerationCard usingCounter: counter.
	acceleration3 := AccelerationCard usingCounter: counter.
	self assert: acceleration2 name equals: 'acceleration2'.
	self assert: acceleration3 name equals: 'acceleration3'.
]
