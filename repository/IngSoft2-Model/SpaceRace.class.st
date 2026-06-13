Class {
	#name : 'SpaceRace',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dice',
		'board',
		'turnManager',
		'activeCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpaceRace class >> withBoard: board andShips: ships andDice: dice [
	^ self new initializeWithBoard: board andShips: ships withDice: dice
]

{ #category : 'as yet unclassified' }
SpaceRace class >> withTotalParsecs: arg1 dividedInSpaces: arg2 andLaps: arg3 andBoardGenerator: arg4 andShips: arg5 andDice: arg6 [

	arg3 < 1 ifTrue: [
		Error signal: 'Amount of laps cannot be less than 1' ].
	arg1 <= 0 ifTrue: [
		Error signal: 'Total parsecs cannot be equal or less than 0' ].
	arg2 < 1 ifTrue: [
		Error signal: 'Board spaces cannot be less than 1' ].
	^ self new
		  initializeWithTotalParsecs: arg1
		  dividedInSpaces: arg2
		  andLaps: arg3
		  andBoardGenerator: arg4
		  andShips: arg5
		  withDice: arg6
]

{ #category : 'as yet unclassified' }
SpaceRace >> activeCards [
 ^ ships flatCollect: [ :ship | ship activeCards ]
]

{ #category : 'as yet unclassified' }
SpaceRace >> activeCardsNames [
	^ self activeCards collect:[:card | card name].
]

{ #category : 'testing' }
SpaceRace >> amountOfShips [

	^ ships size
]

{ #category : 'as yet unclassified' }
SpaceRace >> cardHistoryNames [
	^ cardHistory collect:[:card | card name].
]

{ #category : 'as yet unclassified' }
SpaceRace >> checkTurn: arg1 [

	^ turnManager currentTurn = (ships indexOf: arg1)
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
SpaceRace >> initializeWithBoard: aBoard andShips: arg5 withDice: arg6 [

	board := aBoard.
	ships := OrderedCollection new.
	ships := arg5 collect: [ :arg8 | Ship withName: arg8 ] .
	dice := arg6.
	turnManager := TurnManager withTotalTurns: ships size.
	activeCards := OrderedCollection new
]

{ #category : 'initialization' }
SpaceRace >> initializeWithTotalParsecs: arg1 dividedInSpaces: arg2 andLaps: arg3 andBoardGenerator: arg4 andShips: arg5 withDice: arg6 [

	totalParsecs := arg1.
	laps := arg3.
	board := (1 to: arg2) collect: [ :arg7 |
		         arg4 generateTileWithParsecFactor: totalParsecs / arg2 ].
	ships := OrderedCollection new.
	ships := arg5 collect: [ :arg8 | Ship withName: arg8 ] .
	dice := arg6.
	turnManager := TurnManager withTotalTurns: (ships size).
	cardHistory := OrderedCollection new.
]

{ #category : 'as yet unclassified' }
SpaceRace >> lapPosition: ship [

^board lapPosition: (self selectShip: ship)
]

{ #category : 'execution' }
SpaceRace >> play [

	| ship roll |
	ship := ships at: turnManager currentTurn.
	roll:= (dice collect: [ :aDie | aDie roll ]) sum.
	self hasEnded ifTrue: [
		Error signal: 'Game is over. Ships cannot move anymore.' ].
	board moveShip: ship with: roll.
	self hasEnded ifFalse: [ board applyTileEffectFor: ship among:ships ].
	turnManager changeTurn
]

{ #category : 'status' }
SpaceRace >> ranking [

	^ (ships sorted: [ :aShip :anotherShip |
		   aShip position > anotherShip position ]) collect: [ :ship |
		  ship name ]
]

{ #category : 'as yet unclassified' }
SpaceRace >> selectShip: arg1 [

	^ ships detect: [ :arg2 | arg2 name = arg1 ]
]

{ #category : 'initialization' }
SpaceRace >> setAndUseCancellationCard: cancellationCardName fromShip: shipUsing toTargetCard: targetCardName [

	| targetCard |
	
	self activeCards ifEmpty: [ Error signal: 'Cannot use cancellation card, there are no permanent cards in effect' ].
	
	targetCard:= self activeCards detect: [:card | card name = targetCardName ] ifNone: [ Error signal: 'Cannot use cancellation card on a card that isnt in effect' ].
	
	 self setCard: cancellationCardName fromShip: shipUsing toTargetCard: targetCard .
    self useCard: cancellationCardName  fromShip: shipUsing .

]

{ #category : 'initialization' }
SpaceRace >> setCard: cardName fromShip: shipName toTargetCard: targetCard [
	
    | ship |
ship := self selectShip:shipName.
    ship setCard: cardName toTargetCard: targetCard.
]

{ #category : 'as yet unclassified' }
SpaceRace >> shipActiveCardsNames: shipName [ 
	^ (self selectShip: shipName) activeCardsNames
]

{ #category : 'testing' }
SpaceRace >> shipLap: ship [

^board shipLap: (self selectShip: ship)
]

{ #category : 'as yet unclassified' }
SpaceRace >> shipPosition: shipName [

	^ (ships detect: [ :ship | ship name = shipName ]) position
]

{ #category : 'status' }
SpaceRace >> shipRanking: arg1 [

	^ self ranking indexOf: arg1
]

{ #category : 'as yet unclassified' }
SpaceRace >> shipsHand: arg1 [

	^ (ships detect: [ :arg2 | arg2 name = arg1 ]) hand
]

{ #category : 'as yet unclassified' }
SpaceRace >> useCard: cardName fromShip: shipUsing [

	| ship turnCondition aCard |
	ship := self selectShip: shipUsing.
	turnCondition := turnManager turnMatches: (ships indexOf: ship).
	aCard:= ship useCard: cardName withTurnCondition: (turnCondition).
	aCard effectTo: 'all' among: ships.
	
	cardHistory add: aCard.
]

{ #category : 'as yet unclassified' }
SpaceRace >> useCard: cardName fromShip: shipUsing toShip: shipAffected [

	| ship turnCondition aCard |
	ship := self selectShip: shipUsing.
	
	turnCondition := turnManager turnMatches: (ships indexOf: ship).
	aCard := ship useCard: cardName withTurnCondition: turnCondition.
	
	aCard effectTo: (self selectShip: shipAffected) among: ships.
	
	cardHistory add: aCard.
]

{ #category : 'as yet unclassified' }
SpaceRace >> useRedoCard: redo fromShip: shipUsing toShip: affectedShip [
	
	| targetCard |
	
	cardHistory ifEmpty: [ Error signal: 'Cannot use redo card, no cards have been played yet' ].
	
	targetCard:= cardHistory last.
	
	self setCard: redo fromShip: shipUsing  toTargetCard: targetCard.
	
	(affectedShip = 'all') 
		ifFalse: [self useCard: redo fromShip: shipUsing toShip: affectedShip ]
		ifTrue: [self useCard: redo fromShip: shipUsing ]
	
]

{ #category : 'status' }
SpaceRace >> winner [

	self hasEnded ifFalse: [ Error signal: 'Game is not over yet.' ].
	^ (ships detect: [ :ship | board isWinner: ship ]) name
]
