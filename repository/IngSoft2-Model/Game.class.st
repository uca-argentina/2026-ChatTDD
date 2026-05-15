Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'player',
		'dice',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andShips: amountOfShips andDice: dice [ 
	| aTile |
	aTile := BasicTile new.
	amountOfSpaces<1 ifTrue:[ Error signal: 'Board spaces cannot be less than 1'].

	^(self new)initializeSpaces: amountOfSpaces andTiles: aTile andShips: amountOfShips withDice: dice.
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andTiles: typeOfTile andShips: amountOfShips andDice: dice [ 
	amountOfSpaces<1 ifTrue:[ Error signal: 'Board spaces cannot be less than 1']. 
	^(self new)initializeSpaces: amountOfSpaces andTiles: typeOfTile andShips: amountOfShips withDice: dice
]

{ #category : 'testing' }
Game >> amountOfShips [
	^ships size
]

{ #category : 'execution' }
Game >> changePlayer [

	^ player := player \\ ships size + 1
]

{ #category : 'status' }
Game >> declareWinner [

	self hasEnded ifFalse: [ ^ 'No winner' ].

	^ ships indexOf: (ships detect: [ :each | each hasCrossed: board size ]).
]

{ #category : 'status' }
Game >> finalPositions [

	| finalPositions |
	self hasEnded ifFalse: [
        Error signal: 'Game is not over. Final positions are not defined yet.'
    ].

	ships := ships collect: [ :each | each fixPosition: board size.].
	finalPositions:= ships collect: [ :each | each position.].
	
    ^ finalPositions.


]

{ #category : 'execution' }
Game >> hasEnded [
	^(ships anySatisfy: [:ship | ship hasCrossed: board size]).
]

{ #category : 'initialization' }
Game >> initializeSpaces: amountOfSpaces andTiles: typeOfTiles andShips: amountOfShips withDice: gameDice [
	
	board := OrderedCollection new.
	ships := OrderedCollection new.
	1 to: amountOfShips do: [ :i | ships add: Ship default. ].
	1 to: amountOfSpaces do: [ :i | board add: typeOfTiles ].
	player:=1.
	dice := gameDice. 
]

{ #category : 'testing' }
Game >> isSpeedUp [
	^ true
]

{ #category : 'execution' }
Game >> play [
	| dieRoll dieRolls currentShip|
	currentShip := ships at: player.
	self hasEnded ifTrue:[
		Error signal: 'Game is over. Ships cannot move anymore.'].
	
	dieRolls := dice collect: [:each | each roll].
	dieRoll := dieRolls sum.

	currentShip move: dieRoll .
	
	self hasEnded ifFalse:[
		currentShip move: ((board at: (currentShip position)) giveEffect)].
	
	
	
	self changePlayer.
	
]

{ #category : 'testing' }
Game >> shipPosition: shipNumber [

	^ (ships at: shipNumber) position.
]
