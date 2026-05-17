Class {
	#name : 'SpaceRace',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'currentShipIndex',
		'dice',
		'board',
		'totalParsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpaceRace class >> withTotalParsecs:  amountOfParsecs dividedInSpaces: amountOfSpaces andTiles: typeOfTile andShips: amountOfShips andDice: dice [ 
	amountOfParsecs<=0 ifTrue:[ Error signal: 'Total parsecs can not be equal or less than 0']. 
	amountOfSpaces<1 ifTrue:[ Error signal: 'Board spaces cannot be less than 1']. 
	^(self new)initializeWithTotalParsecs: amountOfParsecs dividedInSpaces: amountOfSpaces andTiles: typeOfTile andShips: amountOfShips withDice: dice
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
	^(ships anySatisfy: [:ship | ship position >= board size]).
]

{ #category : 'initialization' }
SpaceRace >> initializeWithTotalParsecs: amountOfParsecs dividedInSpaces: amountOfSpaces andTiles: typeOfTiles andShips: amountOfShips withDice: gameDice [

	totalParsecs := amountOfParsecs.
	board := OrderedCollection new.
	ships := OrderedCollection new.
	1 to: amountOfShips do: [ :i | ships add: Ship default. ].
	1 to: amountOfSpaces do: [ :i | board add: typeOfTiles ].
	currentShipIndex:=1.
	dice := gameDice. 
]

{ #category : 'execution' }
SpaceRace >> play [
	| dieRoll currentShip |
    currentShip := ships at: currentShipIndex.
    self hasEnded ifTrue: [
        Error signal: 'Game is over. Ships cannot move anymore.' ].

    dieRoll := (dice collect: [ :each | each roll ]) sum.
    currentShip move: dieRoll limitedTo: board size.

    self hasEnded ifFalse: [
        (board at: currentShip position)
            giveEffectTo: currentShip
            among: ships
            limitedTo: board size. ].

    self changePlayer.
	
]

{ #category : 'as yet unclassified' }
SpaceRace >> ranking [
	^(1 to: ships size) sorted: [ :shipA :shipB | ((ships at: shipA) position) > ((ships at: shipB) position) ].
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
