Class {
	#name : 'OverloadCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'shipAffected',
		'name'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
OverloadCard class >> usingCounter: counter [ 
	^(self new) initializeNameUsingCounter: counter.
]

{ #category : 'executing' }
OverloadCard >> effect [

	^  -2
]

{ #category : 'executing' }
OverloadCard >> effectTo: ship among: ships [

	shipAffected := ship name.
	ship effectBy: self
]

{ #category : 'initialization' }
OverloadCard >> initializeNameUsingCounter: extCounter [
	name:= 'overload', (extCounter add)asString.
]

{ #category : 'nil' }
OverloadCard >> name [
	^ name
]

{ #category : 'class management' }
OverloadCard >> rename: newName [
	name := newName.
]
