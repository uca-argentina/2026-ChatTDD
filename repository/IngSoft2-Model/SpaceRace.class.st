Class {
	#name : 'SpaceRace',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dice',
		'board',
		'totalParsecs',
		'laps',
		'turnManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpaceRace class >> withTotalParsecs:  amountOfParsecs dividedInSpaces: amountOfSpaces andLaps: amountOfLaps andBoardGenerator: boardGen andShips: shipNames andDice: dice [

	amountOfLaps<1 ifTrue:[ Error signal: 'Amount of laps cannot be less than 1']. 
	amountOfParsecs<=0 ifTrue:[ Error signal: 'Total parsecs cannot be equal or less than 0']. 
	amountOfSpaces<1 ifTrue:[ Error signal: 'Board spaces cannot be less than 1'].
	 
	^(self new)initializeWithTotalParsecs: amountOfParsecs dividedInSpaces: amountOfSpaces andLaps: amountOfLaps andBoardGenerator: boardGen andShips: shipNames withDice: dice
]

{ #category : 'testing' }
SpaceRace >> amountOfShips [
	^ships size
]

{ #category : 'execution' }
SpaceRace >> applyTileEffectFor: aShip [

	(board at: aShip lapPosition)
		giveEffectTo: aShip
		among: ships
		limitedToSpaces: board size
		andLaps: laps
]

{ #category : 'status' }
SpaceRace >> finalPositions [

    self hasEnded ifFalse: [
        Error signal: 'Game is not over. Final positions are not defined yet.' ].

    ^ ships collect: [ :each | 
        { each name . each currentLap . each lapPosition } ]


]

{ #category : 'execution' }
SpaceRace >> hasEnded [

	^ ships anySatisfy: [ :ship | self isWinner: ship ]
]

{ #category : 'initialization' }
SpaceRace >> initializeWithTotalParsecs: amountOfParsecs dividedInSpaces: amountOfSpaces andLaps: amountOfLaps andBoardGenerator: boardGen andShips: shipNames withDice: gameDice [

	totalParsecs := amountOfParsecs.
	laps := amountOfLaps.
	
	board := (1 to: amountOfSpaces) collect: [ :i |  boardGen generateTileWithParsecFactor: (totalParsecs / amountOfSpaces) ].
	
	ships := OrderedCollection new.
	ships := shipNames collect: [ :name | Ship withName: name ].

	dice := gameDice. 
	turnManager:= TurnManager withTotalTurns: ships size
]

{ #category : 'testing' }
SpaceRace >> isWinner: aShip [

	^ aShip currentLap = laps and: [ aShip lapPosition = board size ]
]

{ #category : 'execution' }
SpaceRace >> moveShip: aShip [

	| dieRoll |
	dieRoll := (dice collect: [ :each | each roll ]) sum.
	aShip move: dieRoll limitedToSpaces: board size andLaps: laps
]

{ #category : 'execution' }
SpaceRace >> play [

	| currentShip |
	currentShip := ships at: turnManager currentTurn.
	self hasEnded ifTrue: [
		Error signal: 'Game is over. Ships cannot move anymore.' ].
	self moveShip: currentShip.
	self hasEnded ifFalse: [ self applyTileEffectFor: currentShip ].
	turnManager changeTurn.
]

{ #category : 'status' }
SpaceRace >> ranking [
    ^ (ships sorted: [:shipA :shipB | 
        (shipA currentLap * board size + shipA lapPosition) >
        (shipB currentLap * board size + shipB lapPosition)]) collect: [:ship | ship name].
]

{ #category : 'as yet unclassified' }
SpaceRace >> selectShip: shipName [
	^(ships detect: [:each | each name = shipName ])
]

{ #category : 'testing' }
SpaceRace >> shipLap: shipName [
	^ (ships detect: [:each | each name = shipName ]) currentLap.
]

{ #category : 'testing' }
SpaceRace >> shipPosition: shipName [
	^ (ships detect: [:each | each name = shipName ]) lapPosition.
]

{ #category : 'status' }
SpaceRace >> shipRanking: ship [
	^(self ranking) indexOf: ship.
]

{ #category : 'as yet unclassified' }
SpaceRace >> shipsHand: shipName [
	^ (ships detect: [:each | each name = shipName ]) hand.
]

{ #category : 'as yet unclassified' }
SpaceRace >> useCard: aCard fromShip: ShipUsing [
	(self selectShip: ShipUsing) useCard: aCard.
]

{ #category : 'status' }
SpaceRace >> winner [

    self hasEnded ifFalse: [
        Error signal: 'Game is not over yet.'].
    ^ (ships detect: [ :ship | self isWinner: ship ]) name.
]
