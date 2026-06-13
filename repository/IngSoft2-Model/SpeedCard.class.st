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

{ #category : 'as yet unclassified' }
SpeedCard class >> usingCounter: extCounter [
	^(self new) initializeNameUsingCounter: extCounter.
]

{ #category : 'as yet unclassified' }
SpeedCard >> effect [

	^ 1
]

{ #category : 'as yet unclassified' }
SpeedCard >> effectTo: arg1 among: arg2 [

	shipAffected := arg1 name.
	arg1 effectBy: self
]

{ #category : 'initialization' }
SpeedCard >> initializeNameUsingCounter: counter [ 
	name:= 'speed', (counter add)asString.
]

{ #category : 'accessing' }
SpeedCard >> name [
	^ name
]
