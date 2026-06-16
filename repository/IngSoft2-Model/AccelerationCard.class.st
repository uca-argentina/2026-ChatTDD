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

{ #category : 'accessing' }
AccelerationCard class >> usingCounter: counter [ 
	^(self new) initializeNameUsingCounter: counter.
]

{ #category : 'executing' }
AccelerationCard >> effect [

	^ 1
]

{ #category : 'executing' }
AccelerationCard >> effectTo: ship among: ships [

	shipAffected := 'all'.
	ships do: [ :aShip | aShip effectBy: self ]
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
