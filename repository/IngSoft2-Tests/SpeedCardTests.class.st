Class {
	#name : 'SpeedCardTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpeedCardTests >> test01WhenFirstSpeedCardCardIsCreatedItsNameIsSpeed1 [

	| speed counter |
	counter := Counter start.
	speed := SpeedCard usingCounter: counter.
	self assert: speed name equals: 'speed1'.
]

{ #category : 'tests' }
SpeedCardTests >> test02WhenACardIsCreatedTheNameReflectsItsPositionAmongAllOtherSpeedCards [

	| speed counter speed2 speed3 |
	counter := Counter start.
	speed := SpeedCard usingCounter: counter.
	speed2 := SpeedCard usingCounter: counter.
	speed3 := SpeedCard usingCounter: counter.
	self assert: speed2 name equals: 'speed2'.
	self assert: speed3 name equals: 'speed3'.
]
