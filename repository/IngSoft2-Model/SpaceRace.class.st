Class {
	#name : 'SpaceRace',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'currentShipIndex',
		'dice',
		'board',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpaceRace class >> withSpaces: amountOfSpaces andLaps: amountOfLaps andShips: amountOfShips andDice: dice [ 
	| aTile |
	aTile := BasicTile new.
	amountOfSpaces<1 ifTrue:[ Error signal: 'Board spaces cannot be less than 1'].
	^(self new)initializeSpaces: amountOfSpaces andLaps: amountOfLaps andTiles: aTile andShips: amountOfShips withDice: dice
]

{ #category : 'as yet unclassified' }
SpaceRace class >> withSpaces: amountOfSpaces andShips: amountOfShips andDice: dice [ 
	| aTile |
	aTile := BasicTile new.
	amountOfSpaces<1 ifTrue:[ Error signal: 'Board spaces cannot be less than 1'].

	^(self new)initializeSpaces: amountOfSpaces andTiles: aTile andShips: amountOfShips withDice: dice.
]

{ #category : 'as yet unclassified' }
SpaceRace class >> withSpaces: amountOfSpaces andTiles: typeOfTile andShips: amountOfShips andDice: dice [ 
	amountOfSpaces<1 ifTrue:[ Error signal: 'Board spaces cannot be less than 1']. 
	^(self new)initializeSpaces: amountOfSpaces andTiles: typeOfTile andShips: amountOfShips withDice: dice
]

{ #category : 'testing' }
SpaceRace >> amountOfShips [
	^ships size
]

{ #category : 'execution' }
SpaceRace >> changePlayer [

	currentShipIndex := currentShipIndex \\ ships size + 1
]

{ #category : 'status' }
SpaceRace >> finalPositions [

	| finalPositions |
	self hasEnded ifFalse: [
        Error signal: 'Game is not over. Final positions are not defined yet.'
    ].

	finalPositions := ships collect: [ :each | each position.].
	
    ^ finalPositions.


]

{ #category : 'execution' }
SpaceRace >> hasEnded [
	^((ships anySatisfy: [:ship | ship position >= board size]) 
	and: (ships anySatisfy: [:ship | ship lap >= laps])).
]

{ #category : 'initialization' }
SpaceRace >> initializeSpaces: amountOfSpaces andLaps: amountOfLaps andTiles: typeOfTiles andShips: amountOfShips withDice: gameDice [ 
	board := OrderedCollection new.
	ships := OrderedCollection new.
	1 to: amountOfShips do: [ :i | ships add: Ship default. ].
	1 to: amountOfSpaces do: [ :i | board add: typeOfTiles ].
	currentShipIndex:=1.
	laps:= amountOfLaps.
	dice := gameDice. 
]

{ #category : 'initialization' }
SpaceRace >> initializeSpaces: amountOfSpaces andTiles: typeOfTiles andShips: amountOfShips withDice: gameDice [
	
	board := OrderedCollection new.
	ships := OrderedCollection new.
	1 to: amountOfShips do: [ :i | ships add: Ship default. ].
	1 to: amountOfSpaces do: [ :i | board add: typeOfTiles ].
	currentShipIndex:=1.
	laps:=1.
	dice := gameDice. 
]

{ #category : 'execution' }
SpaceRace >> play [
	| dieRoll currentShip |
    currentShip := ships at: currentShipIndex.
    self hasEnded ifTrue: [
        Error signal: 'Game is over. Ships cannot move anymore.' ].

    dieRoll := (dice collect: [ :each | each roll ]) sum.
    currentShip move: dieRoll limitedToSpaces: board size andToLaps: laps .

    self hasEnded ifFalse: [
        (board at: currentShip position)
            giveEffectTo: currentShip
            among: ships
            limitedTo: board size. ].

    self changePlayer.
	
]

{ #category : 'as yet unclassified' }
SpaceRace >> ranking [
    ^(1 to: ships size) sorted: [ :shipA :shipB | 
        ((ships at: shipA) lap ~= (ships at: shipB) lap)
            ifTrue:  [ (ships at: shipA) lap > (ships at: shipB) lap ]
            ifFalse: [ (ships at: shipA) position > (ships at: shipB) position ]
    ].
]

{ #category : 'as yet unclassified' }
SpaceRace >> shipLaps: ship [ 
	^ (ships at: ship) lap.
]

{ #category : 'testing' }
SpaceRace >> shipPosition: shipNumber [

	^ (ships at: shipNumber) position.
]

{ #category : 'as yet unclassified' }
SpaceRace >> shipRanking: ship [
	^(self ranking) indexOf: ship.
]

{ #category : 'status' }
SpaceRace >> winner [

	self hasEnded ifFalse:[
		Error signal: 'Game is not over yet.'].

	^ ships indexOf: (ships detect: [ :each | each position >= (board size) ]).
]
