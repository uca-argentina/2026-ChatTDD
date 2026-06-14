Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#instVars : [
		'name',
		'target'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RedoCard class >> usingCounter: counter [
	^(self new) initializeNameUsingCounter: counter.
]

{ #category : 'as yet unclassified' }
RedoCard >> effectTo: affectedShip among: ships [
	target effectTo: affectedShip among: ships .
]

{ #category : 'initialization' }
RedoCard >> initializeNameUsingCounter: counter [ 
	name:= 'redo', (counter add)asString.
]

{ #category : 'testing' }
RedoCard >> isPlayable: canPlayerUseCard [
	target isPlayable: canPlayerUseCard.
]

{ #category : 'accessing' }
RedoCard >> name [
	^ name
]

{ #category : 'accessing' }
RedoCard >> target: targetCard [
	target := (targetCard deepCopy) rename: name.
]

{ #category : 'as yet unclassified' }
RedoCard >> target: targetCard cancelling: aCard [
	target := (targetCard deepCopy) rename: name.
	target target: aCard.
]
