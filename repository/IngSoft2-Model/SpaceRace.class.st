Class {
	#name : 'SpaceRace',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dice',
		'board',
		'totalParsecs',
		'laps',
		'turnManager',
		'cardHistory'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

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

{ #category : 'testing' }
SpaceRace >> amountOfShips [

	^ ships size
]

{ #category : 'execution' }
SpaceRace >> applyTileEffectFor: arg1 [

	(board at: arg1 lapPosition)
		giveEffectTo: arg1
		among: ships
		limitedToSpaces: board size
		andLaps: laps
]

{ #category : 'as yet unclassified' }
SpaceRace >> cardHistory [
	^ cardHistory.
]

{ #category : 'as yet unclassified' }
SpaceRace >> checkTurn: ship [
	^turnManager currentTurn = (ships indexOf: ship).

]

{ #category : 'status' }
SpaceRace >> finalPositions [

	self hasEnded ifFalse: [
		Error signal:
			'Game is not over. Final positions are not defined yet.' ].
	^ ships collect: [ :arg1 |
			  {
				  arg1 name.
				  arg1 currentLap.
				  arg1 lapPosition } ]
]

{ #category : 'execution' }
SpaceRace >> hasEnded [

	^ ships anySatisfy: [ :arg1 | self isWinner: arg1 ]
]

{ #category : 'initialization' }
SpaceRace >> initializeWithTotalParsecs: amountOfParsecs dividedInSpaces: amountOfSpaces andLaps: amountOfLaps andBoardGenerator: boardGen andShips: shipNames withDice: gameDice [

	totalParsecs := amountOfParsecs.
	laps := amountOfLaps.
	
	board := (1 to: amountOfSpaces) collect: [ :i |  boardGen generateTileWithParsecFactor: (totalParsecs / amountOfSpaces) ].
	
	ships := OrderedCollection new.
	ships := shipNames collect: [ :name | Ship withName: name ].

	dice := gameDice. 
	turnManager:= TurnManager withTotalTurns: ships size.
	
	cardHistory := OrderedCollection new.
]

{ #category : 'testing' }
SpaceRace >> isWinner: arg1 [

	^ arg1 currentLap = laps and: [ arg1 lapPosition = board size ]
]

{ #category : 'execution' }
SpaceRace >> moveShip: arg1 [

	| tmp1 |
	tmp1 := (dice collect: [ :arg2 | arg2 roll ]) sum.
	arg1 move: tmp1 limitedToSpaces: board size andLaps: laps
]

{ #category : 'execution' }
SpaceRace >> play [

	| tmp1 |
	tmp1 := ships at: turnManager currentTurn.
	self hasEnded ifTrue: [
		Error signal: 'Game is over. Ships cannot move anymore.' ].
	self moveShip: tmp1.
	self hasEnded ifFalse: [ self applyTileEffectFor: tmp1 ].
	turnManager changeTurn
]

{ #category : 'status' }
SpaceRace >> ranking [

	^ (ships sorted: [ :arg1 :arg2 |
			   arg1 currentLap * board size + arg1 lapPosition
			   > (arg2 currentLap * board size + arg2 lapPosition) ]) collect: [
		  :arg3 | arg3 name ]
]

{ #category : 'as yet unclassified' }
SpaceRace >> selectShip: shipName [
	^(ships detect: [:each | each name = shipName ])
]

{ #category : 'testing' }
SpaceRace >> shipLap: arg1 [

	^ (ships detect: [ :arg2 | arg2 name = arg1 ]) currentLap
]

{ #category : 'testing' }
SpaceRace >> shipPosition: arg1 [

	^ (ships detect: [ :arg2 | arg2 name = arg1 ]) lapPosition
]

{ #category : 'status' }
SpaceRace >> shipRanking: arg1 [

	^ self ranking indexOf: arg1
]

{ #category : 'as yet unclassified' }
SpaceRace >> shipsHand: shipName [
	^ (ships detect: [:each | each name = shipName ]) hand.
]

{ #category : 'as yet unclassified' }
SpaceRace >> useCard: aCard fromShip: ShipUsing [

	| ship |
	ship := self selectShip: ShipUsing.
	(aCard isPermanent and: [ (self checkTurn: ship) not ]) ifTrue: [
        Error signal: 'Ship cant use permanent card outside its turn' ].
	ship useCard: aCard.
	aCard effectTo: (self selectShip: ShipUsing) among: ships.
	cardHistory add: aCard
]

{ #category : 'as yet unclassified' }
SpaceRace >> useCard: aCard fromShip: shipUsing toShip: shipAffected [

	| ship |
	ship := self selectShip: shipUsing.
	(aCard isPermanent and: [ (self checkTurn: ship) not ]) ifTrue: [
        Error signal: 'Ship cant use permanent card outside its turn' ].
	ship useCard: aCard.
	aCard effectTo: (self selectShip: shipAffected) among: ships.
	cardHistory add: aCard
]

{ #category : 'as yet unclassified' }
SpaceRace >> useCard: aCard fromShip: shipUsing toShip: shipAffected cancel: cardEffect [
	| ship |
    ship := self selectShip: shipUsing.
    (aCard isPermanent and: [ (self checkTurn: ship) not ]) ifTrue: [
        Error signal: 'Ship cant use permanent card outside its turn' ].
    ship useCard: aCard.
    aCard effectTo: (self selectShip: shipAffected) among: ships andCancel: cardEffect.
    cardHistory add: aCard.
]

{ #category : 'status' }
SpaceRace >> winner [

	self hasEnded ifFalse: [ Error signal: 'Game is not over yet.' ].
	^ (ships detect: [ :arg1 | self isWinner: arg1 ]) name
]
