Class {
	#name : 'HardcodedCardTile',
	#superclass : 'Object',
	#instVars : [
		'cards',
		'currentTurn',
		'totalTurns'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
HardcodedCardTile class >> thatGives: typeCards [
	^(self new) initializeWithTypeCards: typeCards.
]

{ #category : 'execution' }
HardcodedCardTile >> giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [

	triggeringShip addToHand: (cards at: currentTurn).
	currentTurn:= currentTurn\\ totalTurns + 1.
]

{ #category : 'initialization' }
HardcodedCardTile >> initializeWithTypeCards: typeCards [
	cards := typeCards asOrderedCollection.
	currentTurn := 1.
	totalTurns := typeCards size.
]
