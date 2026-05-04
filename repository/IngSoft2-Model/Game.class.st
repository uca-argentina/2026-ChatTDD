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
	aFixedDie := FixedDie thatRolls: {5.}.
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
	aFixedDie := FixedDie thatRolls: {5.}.
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
	aFixedDie := FixedDie thatRolls: {5.}.
	^(self new)initializeSpaces: amountOfSpaces andShips: amountOfShips withDice: {aFixedDie.}
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andShips: amountOfShips andDice: dice [ 

	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1'].

	^(self new)initializeSpaces: amountOfSpaces andShips: amountOfShips withDice: dice.
]

{ #category : 'as yet unclassified' }
Game >> amountOfShips [
	^ships size
]

{ #category : 'as yet unclassified' }
Game >> declareWinner [
	self hasEnded ifTrue: [ ^ships detectIndex: [:each | each >= 5] ] ifFalse: [ ^'No winner' ].
]

{ #category : 'as yet unclassified' }
Game >> finalPositions [

    | position |
	self hasEnded ifFalse: [
        Error signal: 'Game is not over. Final positions are not defined yet.'
    ].

	1 to: (ships size) do: [ :i | (ships at: i) > totalSpaces ifTrue: [ ships at: i put: totalSpaces ] ].
	
    ^ ships


]

{ #category : 'testing' }
Game >> hasEnded [
	^(ships anySatisfy: [:ship | ship>=totalSpaces]).
]

{ #category : 'initialization' }
Game >> initializeSpaces: amountOfSpaces andShips: amountOfShips withDice: gameDice [
	
	totalSpaces := amountOfSpaces.
	ships := OrderedCollection new.
	1 to: amountOfShips do: [ :i | ships add: 0 ].
	player:=1.
	die := gameDice. 
]

{ #category : 'as yet unclassified' }
Game >> moveShip: roll [ 

	| posicionActual |

	self hasEnded ifTrue:[
		Error signal: 'Game is over. Ships cannot move anymore.'].
	
	posicionActual := ships at: player.
	ships at: player put: posicionActual + roll .
	player := player \\ ships size + 1
]

{ #category : 'as yet unclassified' }
Game >> play [
	| dieRoll dieRolls|
	
	dieRolls := die collect: [:each | each roll].
	dieRoll := dieRolls sum.

	self moveShip: dieRoll .
]

{ #category : 'as yet unclassified' }
Game >> playUntilEnds [
	[ self hasEnded ] whileFalse: [ 
    self play.
] 
]

{ #category : 'as yet unclassified' }
Game >> shipPosition: shipNumber [

	^ ships at: shipNumber
]
