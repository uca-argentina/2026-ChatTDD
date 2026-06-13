Class {
	#name : 'HardcodedCardTile',
	#superclass : 'Object',
	#instVars : [
		'cards',
		'totalTurns',
		'turnManager',
		'counters'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
HardcodedCardTile class >> thatGives: arg1 [

	^ self new initializeWithTypeCards: arg1
]

{ #category : 'as yet unclassified' }
HardcodedCardTile >> createCard: cardType [
    | name |
    name := cardType asString asLowercase.

    name = 'overload' ifTrue: [ ^OverloadCard usingCounter: (counters at:1) ].
    name = 'speed' ifTrue: [ ^SpeedCard usingCounter: (counters at:2) ].
    name = 'acceleration' ifTrue: [ ^AccelerationCard usingCounter: (counters at:3) ].
    name = 'cancellation' ifTrue: [ ^CancellationCard usingCounter: (counters at:4) ].
	name = 'redo' ifTrue: [ ^RedoCard usingCounter: (counters at:5) ].
]

{ #category : 'as yet unclassified' }
HardcodedCardTile >> currentCardType [
 ^ cards at: (turnManager currentTurn)
]

{ #category : 'execution' }
HardcodedCardTile >> giveEffectTo: triggeringShip among: allShips limitedToSpaces: maxSize andLaps: laps [

	triggeringShip addToHand: (self createCard: (self currentCardType)).
	turnManager changeTurn.
]

{ #category : 'initialization' }
HardcodedCardTile >> initializeWithTypeCards: typeCards [
	cards := typeCards asOrderedCollection.
	counters := { Counter start. Counter start. Counter start. Counter start. Counter start.}.
	turnManager := TurnManager withTotalTurns: typeCards size
]
