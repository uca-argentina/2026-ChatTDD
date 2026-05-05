Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'totalSpaces',
		'ships',
		'player',
		'die'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Game class >> default [

	| aFixedDie |
	aFixedDie := LoadedDie thatRolls: {5.}.
	^(self new)initializeSpaces: 5 andShips: 1 withDice: {aFixedDie.}
]

{ #category : 'as yet unclassified' }
Game class >> defaultWithDice: dice [
		^(self new)initializeSpaces: 5 andShips: 1 withDice: dice.
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces [
	| aFixedDie |
	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1'].
	aFixedDie := LoadedDie thatRolls: {5.}.
	^(self new)initializeSpaces: amountOfSpaces andShips: 2 withDice: {aFixedDie.}
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andDice: dice [
	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1']. 
	^(self new)initializeSpaces: amountOfSpaces andShips: 2 withDice: dice
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andShips: amountOfShips [
	| aFixedDie |
	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1'].
	aFixedDie := LoadedDie thatRolls: {5.}.
	^(self new)initializeSpaces: amountOfSpaces andShips: amountOfShips withDice: {aFixedDie.}
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andShips: amountOfShips andDice: dice [ 

	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1'].

	^(self new)initializeSpaces: amountOfSpaces andShips: amountOfShips withDice: dice.
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

	^ ships indexOf: (ships detect: [ :each | each hasCrossed: totalSpaces ]).
]

{ #category : 'status' }
Game >> finalPositions [

	| finalPositions |
	self hasEnded ifFalse: [
        Error signal: 'Game is not over. Final positions are not defined yet.'
    ].

	ships := ships collect: [ :each | each fixPosition: totalSpaces.].
	finalPositions:= ships collect: [ :each | each givePosition.].
	
    ^ finalPositions.


]

{ #category : 'execution' }
Game >> hasEnded [
	^(ships anySatisfy: [:ship | ship hasCrossed: totalSpaces]).
]

{ #category : 'initialization' }
Game >> initializeSpaces: amountOfSpaces andShips: amountOfShips withDice: gameDice [
	
	totalSpaces := amountOfSpaces.
	ships := OrderedCollection new.
	1 to: amountOfShips do: [ :i | ships add: Ship default. ].
	player:=1.
	die := gameDice. 
]

{ #category : 'execution' }
Game >> play [
	| dieRoll dieRolls|
	
	self hasEnded ifTrue:[
		Error signal: 'Game is over. Ships cannot move anymore.'].
	
	dieRolls := die collect: [:each | each roll].
	dieRoll := dieRolls sum.

	(ships at: player) move: dieRoll .
	
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
