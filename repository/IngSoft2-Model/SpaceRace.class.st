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
SpaceRace class >> withTotalParsecs:  amountOfParsecs dividedInSpaces: amountOfSpaces andLaps: amountOfLaps andBoardGenerator: boardGen andShips: arrayOfShips andDice: dice [

	amountOfLaps<1 ifTrue:[ Error signal: 'Amount of laps cannot be less than 1']. 
	amountOfParsecs<=0 ifTrue:[ Error signal: 'Total parsecs cannot be equal or less than 0']. 
	amountOfSpaces<1 ifTrue:[ Error signal: 'Board spaces cannot be less than 1'].
	 
	^(self new)initializeWithTotalParsecs: amountOfParsecs dividedInSpaces: amountOfSpaces andLaps: amountOfLaps andBoardGenerator: boardGen andShips: arrayOfShips withDice: dice
]

{ #category : 'testing' }
SpaceRace >> amountOfShips [
	^ships size
]

{ #category : 'status' }
SpaceRace >> finalPositions [

	| finalPositions |
	self hasEnded ifFalse: [
        Error signal: 'Game is not over. Final positions are not defined yet.'
    ].

	finalPositions := ships collect: [ :each | {each name . each lapPosition} .].
	
    ^ finalPositions.


]

{ #category : 'execution' }
SpaceRace >> hasEnded [
    ^ ships anySatisfy: [:ship | (ship currentLap = laps) and: (ship lapPosition = board size)]

]

{ #category : 'initialization' }
SpaceRace >> initializeWithTotalParsecs: amountOfParsecs dividedInSpaces: amountOfSpaces andLaps: amountOfLaps andBoardGenerator: boardGen andShips: arrayOfShips withDice: gameDice [

	totalParsecs := amountOfParsecs.
	laps := amountOfLaps.
	
	board := OrderedCollection new.
	1 to: amountOfSpaces do: [ :i | board add: (boardGen generateTilewithParsecFactor: (totalParsecs/amountOfSpaces))].
	
	ships := OrderedCollection new.
	1 to: (arrayOfShips size) do: [ :i | ships add: (Ship withName: (arrayOfShips at: i)). ].

	dice := gameDice. 
	turnManager:= TurnManager withTotalTurns: ships size
]

{ #category : 'execution' }
SpaceRace >> play [
	| dieRoll currentShip |
    currentShip := ships at: turnManager currentTurn.
	turnManager changeTurn.
    self hasEnded ifTrue: [
        Error signal: 'Game is over. Ships cannot move anymore.' ].

    dieRoll := (dice collect: [ :each | each roll ]) sum.
    currentShip move: dieRoll limitedToSpaces: board size andLaps: laps.

    self hasEnded ifFalse: [
        (board at: currentShip lapPosition)
            giveEffectTo: currentShip
            among: ships
            limitedToSpaces: board size
				andLaps: laps. ].
]

{ #category : 'as yet unclassified' }
SpaceRace >> ranking [
    ^ (ships sorted: [:shipA :shipB | 
        (shipA currentLap * board size + shipA lapPosition) >
        (shipB currentLap * board size + shipB lapPosition)]) collect: [:ship | ship name].
]

{ #category : 'as yet unclassified' }
SpaceRace >> shipLap: shipName [
	^ (ships detect: [:each | each name = shipName ]) currentLap.
]

{ #category : 'testing' }
SpaceRace >> shipPosition: shipName [
	^ (ships detect: [:each | each name = shipName ]) lapPosition.
]

{ #category : 'as yet unclassified' }
SpaceRace >> shipRanking: ship [
	^(self ranking) indexOf: ship.
]

{ #category : 'status' }
SpaceRace >> winner [

    self hasEnded ifFalse: [
        Error signal: 'Game is not over yet.'].
    ^ (ships detect: [:each | (each currentLap = laps) and: (each lapPosition = board size) ]) name.
]
