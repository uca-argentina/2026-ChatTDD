Class {
	#name : 'AccelerationCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'shipAffected',
		'name'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AccelerationCard class >> usingCounter: counter [ 
	^(self new) initializeNameUsingCounter: counter.
]

{ #category : 'as yet unclassified' }
AccelerationCard >> effect [

	^ 1
]

{ #category : 'as yet unclassified' }
AccelerationCard >> effectTo: arg1 among: arg2 [

	shipAffected := 'all'.
	arg2 do: [ :arg3 | arg3 effectBy: self ]
]

{ #category : 'initialization' }
AccelerationCard >> initializeNameUsingCounter: counter [
	name := 'acceleration', (counter add)asString.
]

{ #category : 'accessing' }
AccelerationCard >> name [
	^ name
]

{ #category : 'class management' }
AccelerationCard >> rename: newName [
	name := newName.
]
