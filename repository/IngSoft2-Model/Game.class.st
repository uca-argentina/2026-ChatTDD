Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'player',
		'die',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Game class >> default [

	| aFixedDie aTile|
	aTile := BasicTile new.
	aFixedDie := LoadedDie thatRolls: {5.}.
	^(self new)initializeSpaces: 5 andTiles: aTile andShips: 1 withDice: {aFixedDie.}
]

{ #category : 'as yet unclassified' }
Game class >> defaultWithDice: dice [
		| aTile |
		aTile := BasicTile new.
		^(self new)initializeSpaces: 5 andTiles: aTile andShips: 1 withDice: dice.
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces [
	| aFixedDie aTile |
	aTile := BasicTile new.
	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1'].
	aFixedDie := LoadedDie thatRolls: {5.}.
	^(self new)initializeSpaces: amountOfSpaces andTiles: aTile andShips: 2 withDice: {aFixedDie.}
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andDice: dice [
	| aTile |
	aTile := BasicTile new.	
	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1']. 
	^(self new)initializeSpaces: amountOfSpaces andTiles: aTile andShips: 2 withDice: dice
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andShips: amountOfShips [
	| aFixedDie aTile  |
	aTile := BasicTile new.
	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1'].
	aFixedDie := LoadedDie thatRolls: {5.}.
	^(self new)initializeSpaces: amountOfSpaces andTiles: aTile andShips: amountOfShips withDice: {aFixedDie.}
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andShips: amountOfShips andDice: dice [ 
	| aTile |
	aTile := BasicTile new.
	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1'].

	^(self new)initializeSpaces: amountOfSpaces andTiles: aTile andShips: amountOfShips withDice: dice.
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andTiles: typeOfTile andDice: dice [ 
	amountOfSpaces<1 ifTrue:[
	Error signal: 'Board spaces cannot be less than 1']. 
	^(self new)initializeSpaces: amountOfSpaces andTiles: typeOfTile andShips: 2 withDice: dice
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
	finalPositions:= ships collect: [ :each | each givePosition.].
	
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
	die := gameDice. 
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
	
	dieRolls := die collect: [:each | each roll].
	dieRoll := dieRolls sum.

	currentShip move: dieRoll .
	
	self hasEnded ifFalse:[
		currentShip move: ((board at: (currentShip givePosition)) giveEffect)].
	
	
	
	self changePlayer.
	
]

{ #category : 'execution' }
Game >> playUntilEnds [
	[ self hasEnded ] whileFalse: [ 
    self play.
] 
]

{ #category : 'testing' }
Game >> shipPosition: shipNumber [

	^ (ships at: shipNumber) givePosition.
]
