Class {
	#name : 'OverloadCardTests',
	#superclass : 'TestCase',
	#instVars : [
		'counter'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
OverloadCardTests >> test01WhenFirstOverloadCardIsCreatedItsNameIsOverload1 [

	| overload |
	counter := Counter start.
	overload := OverloadCard usingCounter: counter.
	self assert: overload name equals: 'overload1'.
]

{ #category : 'tests' }
OverloadCardTests >> test02WhenACardIsCreatedTheNameReflectsItsPositionAmongAllOtherOverloads [

	| overload overload2 overload3 |
	
	counter := Counter start.
	
	overload := OverloadCard usingCounter: counter.
	overload2 := OverloadCard usingCounter: counter.
	overload3 := OverloadCard usingCounter: counter.
	
	self assert: overload2 name equals: 'overload2'.
	self assert: overload3 name equals: 'overload3'.
]
