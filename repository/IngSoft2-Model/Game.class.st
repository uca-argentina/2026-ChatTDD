Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'currentShipIndex',
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

	currentShipIndex := currentShipIndex \\ ships size + 1
]

{ #category : 'status' }
Game >> finalPositions [

	| finalPositions |
	self hasEnded ifFalse: [
        Error signal: 'Game is not over. Final positions are not defined yet.'
    ].

	finalPositions := ships collect: [ :each | each position.].
	
    ^ finalPositions.


]

{ #category : 'execution' }
Game >> hasEnded [
	^(ships anySatisfy: [:ship | ship position >= board size]).
]

{ #category : 'initialization' }
Game >> initializeSpaces: amountOfSpaces andTiles: typeOfTiles andShips: amountOfShips withDice: gameDice [
	
	board := OrderedCollection new.
	ships := OrderedCollection new.
	1 to: amountOfShips do: [ :i | ships add: Ship default. ].
	1 to: amountOfSpaces do: [ :i | board add: typeOfTiles ].
	currentShipIndex:=1.
	dice := gameDice. 
]

{ #category : 'testing' }
Game >> isSpeedUp [
	^ true
]

{ #category : 'execution' }
Game >> play [
	| dieRoll dieRolls currentShip|
	currentShip := ships at: currentShipIndex.
	self hasEnded ifTrue:[
		Error signal: 'Game is over. Ships cannot move anymore.'].
	
	dieRolls := dice collect: [:each | each roll].
	dieRoll := dieRolls sum.

	currentShip move: dieRoll limitedTo: (board size) .
	
	self hasEnded ifFalse:[
		currentShip move: ((board at: (currentShip position)) giveEffect) limitedTo: (board size).].
	
	self changePlayer.
	
]

{ #category : 'testing' }
Game >> shipPosition: shipNumber [

	^ (ships at: shipNumber) position.
]

{ #category : 'status' }
Game >> winner [

	self hasEnded ifFalse:[
		Error signal: 'Game is not over yet.'].

	^ ships indexOf: (ships detect: [ :each | each position >= (board size) ]).
]
