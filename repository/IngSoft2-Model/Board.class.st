Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'laps',
		'tiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> withSpaces: spaces andLaps: laps andTileGenerator: tileGenerator andParsecsPerTile: parsecFactor [
	laps < 1 ifTrue: [
		Error signal: 'Amount of laps cannot be less than 1' ].
	parsecFactor <= 0 ifTrue: [
		Error signal: 'Parsecs per tile cannot be equal or less than 0' ].
	spaces < 1 ifTrue: [
		Error signal: 'Board spaces cannot be less than 1' ].
	^ self new initializeWith: spaces and: laps and: tileGenerator and: parsecFactor
]

{ #category : 'execution' }
Board >> applyTileEffectFor: ship among: ships [

	(tiles at: (self lapPosition: ship))
		giveEffectTo: ship
		among: ships
		in: self
]

{ #category : 'initialization' }
Board >> initializeWith: length and: someLaps and: tileGenerator and: parsecFactor [
tiles := (1 to: length) collect: [ :tile |
tileGenerator generateTileWithParsecFactor: parsecFactor ].
laps:= someLaps

]

{ #category : 'testing' }
Board >> isWinner: aShip [

	^ aShip position = tiles size
]

{ #category : 'as yet unclassified' }
Board >> lapPosition: ship [
^ship position -1\\tiles size+1
]

{ #category : 'execution' }
Board >> moveShip: aShip with: aRoll [

	 aShip move: aRoll limitedTo: tiles size* laps
]

{ #category : 'testing' }
Board >> shipLap: ship [

	^ ship position-1//tiles size + 1
]
