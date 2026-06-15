Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'hand',
		'activeCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Ship class >> withName: nameShip [

	^ self new initializeWithName: nameShip 
]

{ #category : 'accessing' }
Ship >> activeCards [
^ activeCards .
]

{ #category : 'executing' }
Ship >> activeCardsNames [
	^ activeCards collect: [ :card | card name ].
]

{ #category : 'adding' }
Ship >> addToHand: card [

	hand add: card
]

{ #category : 'executing' }
Ship >> calculateEffects [

	^ activeCards sum: [ :card | card effect ] ifEmpty: 0
]

{ #category : 'editing keys' }
Ship >> cancel: target [

	| cardToCancel |
	cardToCancel:= activeCards detect: [ :card | card = target ].
	activeCards remove: cardToCancel.
]

{ #category : 'accessing' }
Ship >> checkCard: target [

	^ activeCards anySatisfy: [ :card | card = target]
]

{ #category : 'executing' }
Ship >> effectBy: card [

	activeCards add: card
]

{ #category : 'accessing' }
Ship >> hand [

	^ hand
]

{ #category : 'initialization' }
Ship >> initializeWithName: nameShip [

	| generator |
	name := nameShip.
	position := 1.
	generator := CardGenerator default .
	hand := {
		        generator giveRandomCard.
		        generator giveRandomCard } asOrderedCollection.
	activeCards := OrderedCollection new
]

{ #category : 'execution' }
Ship >> move: amount [

	| effects |
	effects := self calculateEffects.
	position := position + amount + effects
]

{ #category : 'execution' }
Ship >> move: amount limitedTo:maximumTiles [

	| effects |
	effects := self calculateEffects.
	position := position + amount + effects min: maximumTiles max:1
]

{ #category : 'accessing' }
Ship >> name [

	^ name
]

{ #category : 'accessing' }
Ship >> position [
^position
]

{ #category : 'accessing' }
Ship >> searchCardInHand: cardName [

	^ hand
		  detect: [ :card | card name = cardName ]
		  ifNone: [ Error signal: 'Cant use card that isnt in your hand' ]
]

{ #category : 'initialization' }
Ship >> setCard: cardName toTargetCard: targetCard [
	| card |
	card := self searchCardInHand: cardName.
	card target: targetCard.
]

{ #category : 'initialization' }
Ship >> setCard: cardName toTargetCard: targetCard cancelling: aCard [ 
	| card |
	card := self searchCardInHand: cardName.
	card target: targetCard cancelling: aCard.
]

{ #category : 'initialization' }
Ship >> setCard: cardName withTileEffect: lastTile [ 
		| card |
	card := self searchCardInHand: cardName.
	card target: lastTile.
]

{ #category : 'executing' }
Ship >> useCard: cardName withTurnCondition: canPlayerUseCard [

	| selectedCard |
	selectedCard := self searchCardInHand: cardName.

	selectedCard isPlayable: canPlayerUseCard.

	hand remove: selectedCard.
	^ selectedCard
]
