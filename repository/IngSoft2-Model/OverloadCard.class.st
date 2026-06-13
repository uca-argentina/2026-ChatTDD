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
OverloadCard class >> default [
	^(self new) initializeName.
]

{ #category : 'as yet unclassified' }
OverloadCard class >> usingCounter: counter [ 
	^(self new) initializeNameUsingCounter: counter.
]

{ #category : 'as yet unclassified' }
OverloadCard >> checkPermanent [
	self shouldBeImplemented.
]

{ #category : 'as yet unclassified' }
OverloadCard >> effect [

	^  -2
]

{ #category : 'as yet unclassified' }
OverloadCard >> effectTo: arg1 among: arg2 [

	shipAffected := arg1 name.
	arg1 effectBy: self
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
