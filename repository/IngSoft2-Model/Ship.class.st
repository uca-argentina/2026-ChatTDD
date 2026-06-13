Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
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

{ #category : 'as yet unclassified' }
Ship >> activeCardsNames [
	^ cardHistory collect: [ :card | card name ].
]

{ #category : 'adding' }
Ship >> addToHand: arg1 [

	hand add: arg1
]

{ #category : 'as yet unclassified' }
Ship >> calculateEffects [

	^ cardHistory sum: [ :arg1 | arg1 effect ] ifEmpty: 0
]

{ #category : 'editing keys' }
Ship >> cancel: target [

	| cardToCancel |
	cardToCancel:= cardHistory detect: [ :card | card = target ].
	cardHistory remove: cardToCancel.
]

{ #category : 'as yet unclassified' }
Ship >> checkCard: target [

	^ cardHistory anySatisfy: [ :card | card = target]
]

{ #category : 'as yet unclassified' }
Ship >> effectBy: arg1 [

	cardHistory add: arg1
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
	cardHistory := OrderedCollection new
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
Ship >> setCancellationCard: cancellationCardName toTargetCard: targetCardName [
	| card |
	card := self searchCardInHand: cancellationCardName.
	card target: targetCardName.
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
