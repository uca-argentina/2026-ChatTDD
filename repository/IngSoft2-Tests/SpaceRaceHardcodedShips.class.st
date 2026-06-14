Class {
	#name : 'SpaceRaceHardcodedShips',
	#superclass : 'SpaceRace',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
SpaceRaceHardcodedShips >> applyLastTileEffectFor: ship [ 
	lastTile 
		giveEffectTo: ship
		among: ships
		limitedToSpaces: board size
		andLaps: laps.
]

{ #category : 'initialization' }
SpaceRaceHardcodedShips >> initializeWithTotalParsecs: arg1 dividedInSpaces: arg2 andLaps: arg3 andBoardGenerator: arg4 andShips: arg5 withDice: arg6 [

	totalParsecs := arg1.
	laps := arg3.
	board := (1 to: arg2) collect: [ :arg7 |
		         arg4 generateTileWithParsecFactor: totalParsecs / arg2 ].
	ships := OrderedCollection new.
	ships := arg5 collect: [ :arg8 | HardcodedShip withName: arg8 ] .
	dice := arg6.
	turnManager := TurnManager withTotalTurns: ships size.
	cardHistory := OrderedCollection new.
	lastTile := BasicTile new.
]
