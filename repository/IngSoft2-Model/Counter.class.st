Class {
	#name : 'Counter',
	#superclass : 'Object',
	#instVars : [
		'currentValue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Counter class >> start [
	^(self new) initializeCounter.
]

{ #category : 'adding' }
Counter >> add [
	^ currentValue := currentValue +1.
]

{ #category : 'accessing' }
Counter >> currentValue [
	^ currentValue
]

{ #category : 'initialization' }
Counter >> initializeCounter [
	currentValue :=0.
]
