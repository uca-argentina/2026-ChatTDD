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
Ship class >> withName: arg1 [

	^ self new initializeWithName: arg1
]

{ #category : 'accessing' }
Ship >> activeCards [
^ activeCards .
]

{ #category : 'as yet unclassified' }
Ship >> activeCardsNames [
	^ activeCards collect: [ :card | card name ].
]

{ #category : 'adding' }
Ship >> addToHand: arg1 [

	hand add: arg1
]

{ #category : 'as yet unclassified' }
Ship >> calculateEffects [

	^ activeCards sum: [ :arg1 | arg1 effect ] ifEmpty: 0
]

{ #category : 'editing keys' }
Ship >> cancel: target [

	| cardToCancel |
	cardToCancel:= activeCards detect: [ :card | card = target ].
	activeCards remove: cardToCancel.
]

{ #category : 'as yet unclassified' }
Ship >> checkCard: target [

	^ activeCards anySatisfy: [ :card | card = target]
]

{ #category : 'as yet unclassified' }
Ship >> effectBy: card [

	activeCards add: card
]

{ #category : 'accessing' }
Ship >> hand [

	^ hand
]

{ #category : 'initialization' }
Ship >> initializeWithName: arg1 [

	| tmp1 |
	name := arg1.
	position := 1.
	tmp1 := CardGenerator new.
	hand := {
		        tmp1 giveRandomCard.
		        tmp1 giveRandomCard } asOrderedCollection.
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

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
Ship >> useCard: cardName [

	| selectedCard |
	selectedCard := self searchCardInHand: cardName.

	selectedCard isPlayable.

	hand remove: selectedCard.
	^ selectedCard
]

{ #category : 'as yet unclassified' }
Ship >> useCard: cardName withTurnCondition: canPlayerUseCard [

	| selectedCard |
	selectedCard := self searchCardInHand: cardName.

	selectedCard isPlayable: canPlayerUseCard.

	hand remove: selectedCard.
	^ selectedCard
]
