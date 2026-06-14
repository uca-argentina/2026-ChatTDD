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
		'cardHistory',
		'lastTile'
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
SpaceRace >> applyTileEffectFor: ship [
	|tile|
	tile:= board at: ship lapPosition.
	tile
		giveEffectTo: ship
		among: ships
		limitedToSpaces: board size
		andLaps: laps.
	lastTile := tile.
	
]

{ #category : 'as yet unclassified' }
SpaceRace >> cardHistory [

	^ cardHistory
]

{ #category : 'as yet unclassified' }
SpaceRace >> cardHistoryNames [
	^ self cardHistory collect:[:card | card name].
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
SpaceRace >> initializeWithTotalParsecs: arg1 dividedInSpaces: arg2 andLaps: arg3 andBoardGenerator: arg4 andShips: arg5 withDice: arg6 [

	totalParsecs := arg1.
	laps := arg3.
	board := (1 to: arg2) collect: [ :arg7 |
		         arg4 generateTileWithParsecFactor: totalParsecs / arg2 ].
	ships := OrderedCollection new.
	ships := arg5 collect: [ :arg8 | Ship withName: arg8 ] .
	dice := arg6.
	turnManager := TurnManager withTotalTurns: ships size.
	cardHistory := OrderedCollection new
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
SpaceRace >> selectShip: arg1 [

	^ ships detect: [ :arg2 | arg2 name = arg1 ]
]

{ #category : 'initialization' }
SpaceRace >> setCancellationCard: cancellationCardName fromShip: shipName toTargetCard: targetCardName [ 
	| ship |
	(cardHistory anySatisfy: [ :card | card isPermanent ]) ifFalse: [ Error signal: 'Cannot use cancellation card, there are no permanent cards in effect'  ].
	ship := self selectShip:shipName.
	ship setCancellationCard: cancellationCardName toTargetCard: targetCardName.
]

{ #category : 'as yet unclassified' }
SpaceRace >> shipCardHistoryNames: shipName [ 
	^ (self selectShip: shipName) cardHistoryNames
]

{ #category : 'testing' }
SpaceRace >> shipLap: arg1 [

	^ (ships detect: [ :arg2 | arg2 name = arg1 ]) currentLap
]

{ #category : 'testing' }
SpaceRace >> shipPosition: shipName [

	^ (ships detect: [ :ship | ship name = shipName ]) lapPosition
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
	aCard effectTo: (self selectShip: shipUsing) among: ships inGame: self.
	cardHistory add: aCard
]

{ #category : 'as yet unclassified' }
SpaceRace >> useCard: cardName fromShip: shipUsing toShip: shipAffected [

	| ship turnCondition aCard |
	ship := self selectShip: shipUsing.
	turnCondition := turnManager turnMatches: (ships indexOf: ship).
	aCard := ship useCard: cardName withTurnCondition: turnCondition.
	aCard effectTo: (self selectShip: shipAffected) among: ships inGame: self .
	cardHistory add: aCard
]

{ #category : 'as yet unclassified' }
SpaceRace >> useCard: arg1 fromShip: arg2 toShip: arg3 cancel: arg4 [

	| tmp1 |
	tmp1 := self selectShip: arg2.
	(arg1 isPlayable and: [ (self checkTurn: tmp1) not ]) ifTrue: [
		Error signal: 'Ship cant use permanent card outside its turn' ].
	tmp1 useCard: arg1.
	arg1 effectTo: (self selectShip: arg3) among: ships andCancel: arg4.
	cardHistory add: arg1
]

{ #category : 'status' }
SpaceRace >> winner [

	self hasEnded ifFalse: [ Error signal: 'Game is not over yet.' ].
	^ (ships detect: [ :arg1 | self isWinner: arg1 ]) name
]
