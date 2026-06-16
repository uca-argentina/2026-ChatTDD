Class {
	#name : 'SpeedCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'shipAffected',
		'name'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
SpeedCard class >> usingCounter: counter [
	^(self new) initializeNameUsingCounter: counter.
]

{ #category : 'executing' }
SpeedCard >> effect [

	^ 1
]

{ #category : 'executing' }
SpeedCard >> effectTo: ship among: ships [

	shipAffected := ship name.
	ship effectBy: self
]

{ #category : 'initialization' }
SpeedCard >> initializeNameUsingCounter: counter [ 
	name:= 'speed', (counter add)asString.
]

{ #category : 'accessing' }
SpeedCard >> name [
	^ name
]

{ #category : 'class management' }
SpeedCard >> rename: newName [
	name := newName.
]
