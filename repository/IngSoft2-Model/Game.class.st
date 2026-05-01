Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'totalSpaces',
		'ships',
		'player'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Game class >> default [
	^(self new)initializeSpaces: 5 andShips: 1.
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces [
	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1'].
	^(self new)initializeSpaces: amountOfSpaces.
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces andShips: amountOfShips [
	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1'].
	^(self new)initializeSpaces: amountOfSpaces andShips: amountOfShips .
]

{ #category : 'as yet unclassified' }
Game >> amountOfShips [
	^ships size
]

{ #category : 'as yet unclassified' }
Game >> declareWinner [
	self hasEnded ifTrue: [ ^1 ] ifFalse: [ ^'No winner' ].
]

{ #category : 'testing' }
Game >> hasEnded [
	^(ships anySatisfy: [:ship | ship>=totalSpaces]).
]

{ #category : 'as yet unclassified' }
Game >> initializeSpaces: amountOfSpaces [

	totalSpaces := amountOfSpaces.
	ships := { 0. 0 }.
	player:=1
]

{ #category : 'initialization' }
Game >> initializeSpaces: amountOfSpaces andShips: amountOfShips [

	totalSpaces := amountOfSpaces.
	ships := OrderedCollection new.
	1 to: amountOfShips do: [ :i | ships add: 0 ].
	player:=1
]

{ #category : 'as yet unclassified' }
Game >> moveShip [

	| tmp1 |
	tmp1 := ships at: player.
	ships at: player put: tmp1 + 5.
	player := player \\ ships size + 1
]

{ #category : 'as yet unclassified' }
Game >> moveShip: anInteger [ 

	| tmp1 |
	tmp1 := ships at: player.
	ships at: player put: tmp1 + anInteger .
	player := player \\ ships size + 1
]

{ #category : 'as yet unclassified' }
Game >> shipPosition: shipNumber [

	^ ships at: shipNumber
]
