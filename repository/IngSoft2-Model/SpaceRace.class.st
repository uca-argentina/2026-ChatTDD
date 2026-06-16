Class {
	#name : 'SpaceRace',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dice',
		'board',
		'turnManager',
		'cardHistory'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpaceRace class >> withBoard: board andShips: ships andDice: dice [
	^ self new initializeWithBoard: board andShips: ships withDice: dice
]

{ #category : 'accessing' }
SpaceRace >> activeCards [
 ^ ships flatCollect: [ :ship | ship activeCards ]
]

{ #category : 'accessing' }
SpaceRace >> activeCardsNames [
	^ self activeCards collect:[:card | card name].
]

{ #category : 'testing' }
SpaceRace >> amountOfShips [

	^ ships size
]

{ #category : 'accessing' }
SpaceRace >> cardHistoryNames [
	^ cardHistory collect:[:card | card name].
]

{ #category : 'accessing' }
SpaceRace >> checkTurn: ship [

	^ turnManager current = (ships indexOf: ship)
]

{ #category : 'status' }
SpaceRace >> finalPositions [

	self hasEnded ifFalse: [
		Error signal:
			'Game is not over. Final positions are not defined yet.' ].
	^ ships collect: [ :ship |
			  {
				  ship name.
				  board shipLap:ship.
				  board lapPosition:ship } ]
]

{ #category : 'execution' }
SpaceRace >> hasEnded [

	^ ships anySatisfy: [ :ship | board isWinner: ship ]
]

{ #category : 'initialization' }
SpaceRace >> initializeWithBoard: aBoard andShips: gameShips withDice: die [

	board := aBoard.
	ships := OrderedCollection new.
	ships := gameShips collect: [ :nameShip | Ship withName: nameShip ] .
	dice := die.
	turnManager := CircularIterator withTotalTurns: ships size.
	cardHistory := OrderedCollection new.
]

{ #category : 'accessing' }
SpaceRace >> lapPosition: ship [

^board lapPosition: (self selectShip: ship)
]

{ #category : 'execution' }
SpaceRace >> play [

	| ship roll |
	ship := ships at: turnManager current.
	roll:= (dice collect: [ :aDie | aDie roll ]) sum.
	self hasEnded ifTrue: [
		Error signal: 'Game is over. Ships cannot move anymore.' ].
	board moveShip: ship with: roll.
	self hasEnded ifFalse: [ board applyTileEffectFor: ship among:ships ].
	turnManager next
]

{ #category : 'status' }
SpaceRace >> ranking [

	^ (ships sorted: [ :aShip :anotherShip |
		   aShip position > anotherShip position ]) collect: [ :ship |
		  ship name ]
]

{ #category : 'accessing' }
SpaceRace >> selectShip: nameShip [

	^ ships detect: [ :ship | ship name = nameShip ]
]

{ #category : 'initialization' }
SpaceRace >> setCard: cardName fromShip: shipName toTargetCard: targetCard [
	
    | ship |
	ship := self selectShip:shipName.
    ship setCard: cardName toTargetCard: targetCard.
]

{ #category : 'initialization' }
SpaceRace >> setCard: cardName fromShip: shipName toTargetCard: targetCard cancelling: aCard [
	| ship |
	ship := self selectShip: shipName.
	ship setCard: cardName toTargetCard: targetCard cancelling: aCard.
]

{ #category : 'initialization' }
SpaceRace >> setCard: cardName fromShip: shipName withTileEffect: lastTile [ 
	| ship |
	ship := self selectShip: shipName.
	ship setCard: cardName withTileEffect: lastTile.
]

{ #category : 'accessing' }
SpaceRace >> shipActiveCardsNames: shipName [ 
	^ (self selectShip: shipName) activeCardsNames
]

{ #category : 'testing' }
SpaceRace >> shipLap: ship [

^board shipLap: (self selectShip: ship)
]

{ #category : 'accessing' }
SpaceRace >> shipPosition: shipName [

	^ (ships detect: [ :ship | ship name = shipName ]) position
]

{ #category : 'status' }
SpaceRace >> shipRanking: ship [

	^ self ranking indexOf: ship
]

{ #category : 'accessing' }
SpaceRace >> shipsHand: ship [

	^ (ships detect: [ :aShip | aShip name = ship ]) hand
]

{ #category : 'initialization' }
SpaceRace >> useCancellationCard: cancellationCardName fromShip: shipUsing toTargetCard: targetCardName [

	| targetCard |
	
	self activeCards ifEmpty: [ Error signal: 'Cannot use cancellation card, there are no permanent cards in effect' ].
	
	targetCard:= self activeCards detect: [:card | card name = targetCardName ] ifNone: [ Error signal: 'Cannot use cancellation card on a card that isnt in effect' ].
	
	 self setCard: cancellationCardName fromShip: shipUsing toTargetCard: targetCard .
    self useCard: cancellationCardName  fromShip: shipUsing .

]

{ #category : 'executing' }
SpaceRace >> useCard: cardName fromShip: shipUsing [

	| ship turnCondition aCard |
	ship := self selectShip: shipUsing.
	turnCondition := turnManager currentMatches: (ships indexOf: ship).
	aCard:= ship useCard: cardName withTurnCondition: (turnCondition).
	aCard effectTo: 'all' among: ships.
	
	cardHistory add: aCard.
]

{ #category : 'executing' }
SpaceRace >> useCard: cardName fromShip: shipUsing toShip: shipAffected [

	| ship turnCondition aCard |
	ship := self selectShip: shipUsing.
	
	turnCondition := turnManager currentMatches: (ships indexOf: ship).
	aCard := ship useCard: cardName withTurnCondition: turnCondition.
	
	aCard effectTo: (self selectShip: shipAffected) among: ships.
	
	cardHistory add: aCard.
]

{ #category : 'executing' }
SpaceRace >> useRedoCard: redo fromShip: shipUsing toShip: affectedShip ifCancellingCancel: affectedCardName [

	| targetCard affectedCard |

	cardHistory ifEmpty: [ Error signal: 'Cannot use redo card, no cards have been played yet' ].

	targetCard := cardHistory last.

	affectedCard := self activeCards
		detect: [ :card | card name = affectedCardName ]
		ifNone: [ Error signal: 'If last card is cancellation it will not work on a card that isnt in effect' ].

	self setCard: redo fromShip: shipUsing toTargetCard: targetCard cancelling: affectedCard.

	(affectedShip = 'all')
		ifFalse: [ self useCard: redo fromShip: shipUsing toShip: affectedShip ]
		ifTrue: [ self useCard: redo fromShip: shipUsing ]
]

{ #category : 'executing' }
SpaceRace >> useRepeatCard: repeat fromShip: shipUsing toShip: affectedShip [

	 self setCard: repeat fromShip: shipUsing withTileEffect: (board lastTile).
    self useCard: repeat  fromShip: shipUsing toShip: affectedShip .
]

{ #category : 'status' }
SpaceRace >> winner [

	self hasEnded ifFalse: [ Error signal: 'Game is not over yet.' ].
	^ (ships detect: [ :ship | board isWinner: ship ]) name
]
