Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'currentLap',
		'absPosition',
		'lapPosition',
		'name',
		'hand',
		'cardHistory'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Ship class >> withName: arg1 [

	^ self new initializeWithName: arg1
]

{ #category : 'adding' }
Ship >> addToHand: aCard [ 
	hand add: aCard.
]

{ #category : 'as yet unclassified' }
Ship >> calculateEffects [
	^ cardHistory sum: [ :card | card effect ] ifEmpty: 0 

]

{ #category : 'editing keys' }
Ship >> cancel: aCard [ 
	cardHistory remove: aCard ifAbsent: nil.
]

{ #category : 'as yet unclassified' }
Ship >> checkCard: aCard [ 
	^ (cardHistory includes: aCard).
]

{ #category : 'accessing' }
Ship >> currentLap [

	^ currentLap
]

{ #category : 'as yet unclassified' }
Ship >> effectBy: aCard [ 
	cardHistory add: aCard.
]

{ #category : 'accessing' }
Ship >> hand [
	^ hand.
]

{ #category : 'initialization' }
Ship >> initializeWithName: arg1 [

	| cardGenerator |
	name := arg1.
	absPosition := 1.
	lapPosition := 1.
	currentLap := 1.
	cardGenerator := CardGenerator new.
	hand := {cardGenerator giveRandomCard . cardGenerator giveRandomCard} asOrderedCollection .
	cardHistory := OrderedCollection new.
]

{ #category : 'execution' }
Ship >> lapPosition [

	^ lapPosition
]

{ #category : 'execution' }
Ship >> move: arg1 limitedToSpaces: arg2 andLaps: arg3 [
	| efects |
	efects := self calculateEffects.
	absPosition := (absPosition + arg1 + efects) min: arg2 * arg3 max: 1.
	self
		setCurrentLap: arg2;
		setLapPosition: arg2
		
	
"calcularEfectos:
	^ historialCartas sum: [ :carta | carta effect ]
"
]

{ #category : 'accessing' }
Ship >> name [

	^ name
]

{ #category : 'execution' }
Ship >> resetToStartOfLap [

	lapPosition := 1
]

{ #category : 'initialization' }
Ship >> setCurrentLap: arg1 [

	currentLap := absPosition - 1 // arg1 + 1
]

{ #category : 'initialization' }
Ship >> setLapPosition: arg1 [

	lapPosition := absPosition - 1 \\ arg1 + 1
]

{ #category : 'as yet unclassified' }
Ship >> useCard: aCard [ 
	(hand includes: aCard) ifFalse: [ Error signal: 'Cant use card that isnt in your hand'].
	hand remove: aCard.
]
