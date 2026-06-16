Class {
	#name : 'SpaceRaceTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceRaceTests >> test01WhenTheGameIsNotOverThenTheGameHasNotEnded [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon' } andDice: {aLoadedDie }.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test02WhenShipPassesFinishLineTheGameHasEnded [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon' } andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test03WhenTheShipMovesButDoesntCrossFinishLineThenTheGameDoesNotEnd [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon' } andDice: {aLoadedDie }.
	aGame play.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test04WhenBoardLengthIsZeroThenGameNotCreated [

	| aBoard aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile:= NoEffectTile new.   
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	
	self
		should: [
		aBoard := Board withSpaces: 0 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5. ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Board spaces cannot be less than 1' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test05WhenBoardLengthIsNegativeThenGameNotCreated [

	| aBoard aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile:= NoEffectTile new.   
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	
	self
		should: [
		aBoard := Board withSpaces: -3 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5. ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Board spaces cannot be less than 1' ]

]

{ #category : 'tests' }
SpaceRaceTests >> test06WhenAGameIsCreateWith2ShipsThenTheGameHas2Ships [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	self assert: (aGame amountOfShips) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test07WhenTwoShipsAreMovedThenBothShipsChangePosition [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 'tie fighter')equals: 6.
]

{ #category : 'tests' }
SpaceRaceTests >> test08WhenEachShipMovesThenItMovesItsOwnAmountOfSquares [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 'millenium falcon') equals: 6.
	self assert: (aGame shipPosition: 'tie fighter') equals: 6.
]

{ #category : 'tests' }
SpaceRaceTests >> test09WhenFirstShipWinsThenTheGameEnds [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test10WhenSecondShipWinsThenTheGameEnds [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5. 7}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test11WhenTheGameIsCreatedWith4ShipsThen4ShipsExist [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'maty'. 'lu'. 'teo'. 'eddie' } andDice: {aLoadedDie }.
	self assert: aGame amountOfShips equals: 4.
]

{ #category : 'tests' }
SpaceRaceTests >> test12WhenTheOnlyPlayerWinsThenThePlayerIsTheWinner [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon' } andDice: {aLoadedDie }.
	aGame play.
	self assert: aGame winner equals: 'millenium falcon'.
]

{ #category : 'tests' }
SpaceRaceTests >> test13WhenTheGameIsntFinishedThenThereIsNoWinner [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon' } andDice: {aLoadedDie }.
	aGame play.
	
	self
		should: [
		aGame winner.]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Game is not over yet.' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test14WhenSecondPlayerWinsThenIsDeclaredWinner [
		
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {1. 7}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	
	aGame play.
	aGame play.
	self assert: aGame winner equals: 'tie fighter'.
]

{ #category : 'tests' }
SpaceRaceTests >> test15WhenSomeoneWonThenNoShipCanKeepPlaying [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {6.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon' } andDice: {aLoadedDie }.
		aGame play.  "la nave gana"
		self should: [ aGame play ] raise: Error
		withExceptionDo:[ :error |
			self
				assert: error messageText
				equals: 'Game is over. Ships cannot move anymore.']	
]

{ #category : 'tests' }
SpaceRaceTests >> test16WhenTheGameEndedThenFinalPositionOfShipIs5 [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'tie fighter' } andDice: {aLoadedDie }.
	aGame play.
	self
		assert: aGame finalPositions
		equals: { { 'tie fighter'. 1. 5 } }
]

{ #category : 'tests' }
SpaceRaceTests >> test17WhenAGameIsNotOverThenFinalPositionsAreNotDefined [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {3.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'tie fighter' } andDice: {aLoadedDie }.
	aGame play.
	self
			should:[
				aGame finalPositions .
				]
			raise: Error
			withExceptionDo:[ :error |
				self
					assert: error messageText
					equals: 'Game is not over. Final positions are not defined yet.']	
]

{ #category : 'tests' }
SpaceRaceTests >> test18WhenAShipCrossedTheFinishLineThenItsFinalPositionIsTheLastSpace [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {8.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'tie fighter' } andDice: {aLoadedDie }.

	aGame play.
	self assert: aGame finalPositions equals: { { 'tie fighter'. 1. 5 } }
]

{ #category : 'tests' }
SpaceRaceTests >> test19WhenGameWithMultiplePlayersEndsThenReturnsEachPlayerFinalPosition [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5. 0}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	aGame play.
	self assert: aGame finalPositions equals: {
			{ 'millenium falcon'. 1. 5 }.
			{ 'tie fighter'. 1. 1 } }
]

{ #category : 'tests' }
SpaceRaceTests >> test20WhenGameHasMultipleDiceThenTheShipsShouldMoveTheSumOfTheDice [

	|aGame aLoadedDie anotherLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {3.}.
	anotherLoadedDie :=LoadedDie thatRolls: {3.}.
	aTile:= NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'tie fighter' } andDice: {aLoadedDie. anotherLoadedDie }.
    aGame play.
    self assert: (aGame shipPosition:'tie fighter' ) equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test21WhenShipLandsOnSpeedUpTileThenItMovesForward4Tiles [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {1.}.
	aTile := SpeedUpTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 6 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/6.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 'millenium falcon') equals: 6. 
]

{ #category : 'tests' }
SpaceRaceTests >> test22WhenShipsEndsOnASpeedUpTileThenGameEndsAndSpeedUpIsntPlayed [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile := SpeedUpTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/6.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	aGame play.
	
	self
			should:[ aGame play. ]
			raise: Error
			withExceptionDo:[ :error |
				self
					assert: error messageText
					equals: 'Game is over. Ships cannot move anymore.']	
]

{ #category : 'tests' }
SpaceRaceTests >> test23WhenShip1PlaysThenItCannotPlayAgainUntilShip2Plays [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {4.}.
	aTile := NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 10 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/10.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
    aGame play.  "juega nave 1, mueve 4"
    aGame play.  "juega nave 2, mueve 4"
    self assert: (aGame shipPosition: 'millenium falcon') equals: 5.
    self assert: (aGame shipPosition: 'tie fighter') equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test24WhenShipLandsOnSpeedUpAndMovesToAnotherSpeedUpTheEffectsDontStack [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {2.}.
	aTile := SpeedUpTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/6.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.

	aGame play.
	self assert: (aGame shipPosition: 'millenium falcon') equals: 7. 
]

{ #category : 'tests' }
SpaceRaceTests >> test25WhenShipLandsOnWormHoleTileThenItMovesBack4Tiles [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile := WormHoleTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/6.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.

	aGame play.
	self assert: (aGame shipPosition: 'millenium falcon') equals: 2. 
]

{ #category : 'tests' }
SpaceRaceTests >> test26WhenShipLandsOnWormHoleTileThenItCannotGoBehindPosition0 [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {2.}.
	aTile := WormHoleTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/6.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 'millenium falcon') equals: 1. 
]

{ #category : 'tests' }
SpaceRaceTests >> test27WhenShipLandsOnMoonWalkTileThenShipIsntAffected [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 2 }.
	aTile := MoonWalkTile withAmountBack: 1.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 7
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon'. 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 'millenium falcon') equals: 3
]

{ #category : 'tests' }
SpaceRaceTests >> test28WhenSecondShipLandsOnMoonWalkTileThenTheOtherShipsMoveBackNTiles [

	| aGame aLoadedDie aTile anAmountBack aBoardGenerator |
	anAmountBack := 1.
	aLoadedDie := LoadedDie thatRolls: { 2 }.
	aTile := MoonWalkTile withAmountBack: anAmountBack.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 7
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon'. 'tie fighter'. 'xwing' }
		         andDice: { aLoadedDie }.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 'millenium falcon') equals: 2.
	self assert: (aGame shipPosition: 'tie fighter') equals: 3.
	self assert: (aGame shipPosition: 'xwing') equals: 1
]

{ #category : 'tests' }
SpaceRaceTests >> test29WhenAShipLandsOnAtomicBombTileThenAllShipsGoBackToTheStart [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 6 }.
	aTile := AtomicBombTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 8
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 'tie fighter') equals: 1
]

{ #category : 'tests' }
SpaceRaceTests >> test30WhenParsecFactorIsEqualOrLessThan0ThenSpaceRaceIsntCreated [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 1 }.
	aTile := HyperJumpTile withParsecFactor: -100 / 8 and: {
			         { 80. 'Parsecs' }.
			         { 50. 'Parsecs' }.
			         { 20. 'Parsecs' } }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.

	self
		should: [
				aGame := SpaceRace
					         withBoard: (Board
							          withSpaces: 10
							          andLaps: 1
							          andTileGenerator: aBoardGenerator
							          andParsecsPerTile: -100 / 6)
					         andShips: 1
					         andDice: { aLoadedDie } ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Parsecs per tile cannot be equal or less than 0' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test31WhenAShipLandsOnHyperJumpTileThenTheShipMovesInParsecs [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 1 }.
	aTile := HyperJumpTile withParsecFactor: 100 / 8 and: {
			         { 80. 'Parsecs' }.
			         { 50. 'Parsecs' }.
			         { 20. 'Parsecs' } }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 8
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 'tie fighter') equals: 8
]

{ #category : 'tests' }
SpaceRaceTests >> test32WhenMultipleShipsLandOnHyperJumpThenJumpDistanceRotates [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 1 }.
	aTile := HyperJumpTile withParsecFactor: 100 / 16 and: {
			         { 80. 'Parsecs' }.
			         { 50. 'Parsecs' }.
			         { 20. 'Parsecs' } }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 25
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon'. 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play. "1+ (80//6.25) = 13"
	aGame play. "1+ (50//6.25) = 9"
	aGame play. "13 + 1 + (20//6.25) = 17"
	aGame play. "9 + 1 + (80//6.25) = 22"
	self assert: (aGame shipPosition: 'millenium falcon') equals: 18.
	self assert: (aGame shipPosition: 'tie fighter') equals: 23
]

{ #category : 'tests' }
SpaceRaceTests >> test33WhenSecondShipIsAheadFirstOneThenSecondShipIsFirstInRanking [

	| aGame aDie aTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3. 4 }.
	aTile := NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 8
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon'. 'tie fighter' }
		         andDice: { aDie }.
	aGame play.
	aGame play.
	self
		assert: aGame ranking
		equals: { 'tie fighter'. 'millenium falcon' }
]

{ #category : 'tests' }
SpaceRaceTests >> test34WhenShipIsPassedByOtherShipThenItFallsInTheRanking [

	| aGame aDie aTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3. 4 }.
	aTile := NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 8
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon'. 'tie fighter' }
		         andDice: { aDie }.
	aGame play. "juega nave 1, pos 3"
	aGame play. "juega nave 2, pos 4"
	self assert: (aGame shipRanking: 'tie fighter') equals: 1
]

{ #category : 'tests' }
SpaceRaceTests >> test35WhenTheAmountOfLapsInAGameIsLessThan1ThenGameCannotBeCreated [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	self
		should: [
				aGame := SpaceRace
					         withBoard: (Board
							          withSpaces: 10
							          andLaps: 0
							          andTileGenerator: aBoardGenerator
							          andParsecsPerTile: 100 / 6)
					         andShips: 1
					         andDice: { aLoadedDie } ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Amount of laps cannot be less than 1' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test36WhenShipJustCompletesFirstLapThenTheGameHasntEnded [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 5
				          andLaps: 2
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon'. 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play.
	self deny: aGame hasEnded
]

{ #category : 'tests' }
SpaceRaceTests >> test37WhenAShipCompletesALapItsLapIncrements [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 5
				          andLaps: 2
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon' }
		         andDice: { aLoadedDie }.
	aGame play.
	self assert: (aGame shipLap: 'millenium falcon') equals: 2
]

{ #category : 'tests' }
SpaceRaceTests >> test38WhenAShipCompletesALapThenItReturnsToFirstTile [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 5
				          andLaps: 2
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon' }
		         andDice: { aLoadedDie }.
	aGame play.
	self assert: (aGame lapPosition: 'millenium falcon') equals: 1
]

{ #category : 'tests' }
SpaceRaceTests >> test39WhenShipIsOnLastLapItCannotGoBeyondLastTile [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 8 }.
	aTile := NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 5
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 'tie fighter') equals: 5
]

{ #category : 'tests' }
SpaceRaceTests >> test40WhenShipFallsOnAtomicBombThenLapsAreKept [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 7 }.
	aTile := AtomicBombTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 5
				          andLaps: 3
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play.
	self assert: (aGame shipLap: 'tie fighter') equals: 2
]

{ #category : 'tests' }
SpaceRaceTests >> test41WhenShip1IsAheadInLapsThenItIsFirstInRanking [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5. 1 }.
	aTile := NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 5
				          andLaps: 2
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon'. 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play. "nave 1 completa vuelta, lap=2"
	aGame play. "nave 2 avanza 1"
	self
		assert: aGame ranking
		equals: { 'millenium falcon'. 'tie fighter' }
]

{ #category : 'tests' }
SpaceRaceTests >> test42WhenShipOnLap2LandsOnWormHoleThenItCanGoToPreviousLap [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := WormHoleTile new.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 5
				          andLaps: 3
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play. "lap 2 pos 1 - 4"
	self assert: (aGame shipPosition: 'tie fighter') equals: 2.
	self assert: (aGame shipLap: 'tie fighter') equals: 1
]

{ #category : 'tests' }
SpaceRaceTests >> test43WhenShipLandsOnMoonWalkThenOtherShipsCanGoToPreviousLap [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := MoonWalkTile withAmountBack: 4.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 5
				          andLaps: 3
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon'. 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play. "nave 1 completa vuelta, lap=2 pos=1"
	aGame play. "nave 2 avanza 5 (lap=2 pos=1), cae en moonwalk -4 → nave 1 va a pos=1 lap=2"
	self assert: (aGame shipPosition: 'millenium falcon') equals: 2.
	self assert: (aGame shipLap: 'millenium falcon') equals: 1
]

{ #category : 'tests' }
SpaceRaceTests >> test44WhenUsingTileConstructorNoEffectTileAppearsWith30PercentChance [

	| constructor tile anotherTile |
	constructor := TileGenerator new.
	tile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 30.
	self assert: (tile isKindOf: NoEffectTile).
	
	anotherTile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 31.
	self deny: (anotherTile isKindOf: NoEffectTile).
]

{ #category : 'tests' }
SpaceRaceTests >> test45WhenUsingTileConstructorSpeedUpTileAppearsWith10PercentChance [

	| constructor tile anotherTile |
	constructor := TileGenerator new.
	tile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 80.
	self assert: (tile isKindOf: SpeedUpTile ).
	
	anotherTile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 81.
	self deny: (anotherTile isKindOf: SpeedUpTile ).
]

{ #category : 'tests' }
SpaceRaceTests >> test46WhenUsingTileConstructorTilesAppearBetweenExpectedValues [
    | constructor basicTile cardTile wormHoleTile speedUpTile moonWalkTile hyperJumpTile atomicBombTile |
	constructor := TileGenerator new.
	
   basicTile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 30.
	self assert: (basicTile isKindOf: NoEffectTile).
	
	cardTile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 40.
	self assert: (cardTile isKindOf: CardTile ).
	
	wormHoleTile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 60.
	self assert: (wormHoleTile isKindOf: WormHoleTile ).
	
	speedUpTile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 80.
	self assert: (speedUpTile isKindOf: SpeedUpTile ).
	
	moonWalkTile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 90.
	self assert: (moonWalkTile isKindOf: MoonWalkTile ).
	
	hyperJumpTile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 98.
	self assert: (hyperJumpTile isKindOf: HyperJumpTile ).
	
	atomicBombTile := constructor generateTileWithParsecFactor: (100/8) andChances: { 30. 10. 20. 20. 10. 8. 2 } andNumber: 100.
	self assert: (atomicBombTile isKindOf: AtomicBombTile ).
	
]

{ #category : 'tests' }
SpaceRaceTests >> test47WhenShipIsCreatedThenItStartsWithTwoCards [

	| aGame aDie aTile constructor aCard |
	aDie := LoadedDie thatRolls: { 3 }.
	aCard := Card new.
	aTile := NoEffectTile new.
	constructor := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		        withBoard: (Board
				         withSpaces: 5
				         andLaps: 1
				         andTileGenerator: constructor
				         andParsecsPerTile: 100 / 6)
		        andShips: { 'tie fighter' }
		        andDice: { aDie }.
	self assert: (aGame shipsHand: 'tie fighter') size equals: 2
]

{ #category : 'tests' }
SpaceRaceTests >> test48WhenShipLandsOnCardTileThenItReceivesACard [

	| aGame aDie aCard constructor aTile |
	aDie := LoadedDie thatRolls: { 3 }.
	aCard := Card new.
	aTile := CardTile default.
	constructor := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		        withBoard: (Board
				         withSpaces: 5
				         andLaps: 1
				         andTileGenerator: constructor
				         andParsecsPerTile: 100 / 6)
		        andShips: { 'tie fighter' }
		        andDice: { aDie }.
	aGame play.
	self assert: (aGame shipsHand: 'tie fighter') size equals: 3
]

{ #category : 'tests' }
SpaceRaceTests >> test49WhenShipUsesCardThenItsDeletedFromItsHand [

	| aGame aLoadedDie aTile aBoardGenerator overload |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	overload := OverloadCard new.
	aTile := HardcodedCardTile thatGives: { 'overload' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 5
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter' }
                 andDice: { aLoadedDie }.
		
	aGame play. 
	aGame useCard: 'overload1' fromShip: 'tie fighter' toShip: 'tie fighter'.
	aGame play. 
	self
		assert: ((aGame shipsHand: 'tie fighter') size)
		equals: 2
]

{ #category : 'tests' }
SpaceRaceTests >> test50WhenAShipTriesToUseACardThatIsntInItsHandThenItThrowsError [

	| aGame aDie aTile constructor aCard |
	aDie := LoadedDie thatRolls: { 3 }.
	aCard := OverloadCard new.
	aTile := NoEffectTile new.
	constructor := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		        withBoard: (Board
				         withSpaces: 5
				         andLaps: 1
				         andTileGenerator: constructor
				         andParsecsPerTile: 100 / 6)
		        andShips: { 'tie fighter' }
		        andDice: { aDie }.
	aGame play.
	self
		should: [
		aGame useCard: aCard fromShip: 'tie fighter' toShip: 'tie fighter' ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Cant use card that isnt in your hand' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test51WhenACardIsUsedThenTheGamesCardHistoryAddsIt [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 5
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter' }
		         andDice: { aDie }.
	aGame
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'tie fighter'.
	self assert: aGame activeCardsNames equals: { 'overload1' }
]

{ #category : 'tests' }
SpaceRaceTests >> test52WhenAShipTriesToUseAPermanentCardOutsideItsTurnThenItIsNotAllowed [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 5
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'.'x-wing' }
		         andDice: { aDie }.
	aGame play.

	self
		should: [
				aGame
					useCard: 'overload1'
					fromShip: 'tie fighter'
					toShip: 'tie fighter' ]
		raise: Error
		withExceptionDo: [ :arg1 |
				self
					assert: arg1 messageText
					equals: 'Ship cant use permanent card outside its turn' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test53WhenOverloadCardAppliedThenShipAffectedMovesTwoSpacesLess [

    | aGame aDie aCardTile aBoardGenerator |
    aDie := LoadedDie thatRolls: { 3 }.
    aCardTile := HardcodedCardTile thatGives: { 'overload' }.
    aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
    aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 5
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter' }
                 andDice: { aDie }.
    aGame
        play;
        useCard: 'overload1' fromShip: 'tie fighter' toShip: 'tie fighter';
        play.
    self assert: (aGame shipPosition: 'tie fighter') equals: 5
]

{ #category : 'tests' }
SpaceRaceTests >> test54WhenOverloadCardMakesShipMoveBackwardsThenShipGoesBack [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	    aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 5
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter' }
                 andDice: { aDie }.
	aGame
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'tie fighter';
		play.
	self assert: (aGame shipPosition: 'tie fighter') equals: 1
]

{ #category : 'tests' }
SpaceRaceTests >> test55WhenSpeedCardAppliedThenShipAffectedMovesOneSpaceMore [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'speed' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	    aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 10
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter' }
                 andDice: { aDie }.
	aGame
		play;
		useCard: 'speed1' fromShip: 'tie fighter' toShip: 'tie fighter';
		play.
	self assert: (aGame shipPosition: 'tie fighter') equals: 8
]

{ #category : 'tests' }
SpaceRaceTests >> test56WhenAccelerationCardUsedThenAllShipsMove1SpaceMore [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'acceleration' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 10
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'. 'x wing' }
		         andDice: { aDie }.
	aGame
		play;
		play;
		useCard: 'acceleration1' fromShip: 'tie fighter';
		play;
		play.
	self
		assert: (aGame shipPosition: 'tie fighter') equals: 8;
		assert: (aGame shipPosition: 'x wing') equals: 8
]

{ #category : 'tests' }
SpaceRaceTests >> test57WhenInstantCardIsUsedOutsideShipsTurnThenItIsAppliedAnyways [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 20
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'. 'xwing' }
		         andDice: { aDie }.
	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'xwing';
		play;
		play;
		useCancellationCard: 'cancellation1'
		fromShip: 'xwing'
		toTargetCard: 'overload1';
		play;
		play.
	self assert: (aGame shipPosition: 'xwing') equals: 8
]

{ #category : 'tests' }
SpaceRaceTests >> test58WhenInstantCardIsUsedThenItDoesntShowUpInActiveCards [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 20
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'. 'xwing' }
		         andDice: { aLoadedDie }.

	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'xwing';
		play;
		play.

	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: { 'overload1' } asOrderedCollection.
	self assert: (aGame shipPosition: 'xwing') equals: 5.

	aGame
		useCancellationCard: 'cancellation1'
		fromShip: 'xwing'
		toTargetCard: 'overload1'.

	self assert: aGame activeCardsNames equals: {  }.

	aGame
		play;
		play.

	self assert: (aGame shipPosition: 'xwing') equals: 8
]

{ #category : 'tests' }
SpaceRaceTests >> test59WhenCancellationCardUsedThenASelectedPermanentEffectIsRemovedFromShipAffected [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 20
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'. 'xwing' }
		         andDice: { aLoadedDie }.

	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'xwing';
		play;
		play.

	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: { 'overload1' } asOrderedCollection.
	self assert: (aGame shipPosition: 'xwing') equals: 5.

	aGame
		useCancellationCard: 'cancellation1'
		fromShip: 'xwing'
		toTargetCard: 'overload1'.

	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: {  } asOrderedCollection.

	aGame
		play;
		play.

	self assert: (aGame shipPosition: 'xwing') equals: 8
]

{ #category : 'tests' }
SpaceRaceTests >> test60WhenCancellationCardIsUsedButThereAreNotAnyPermanentsThenItRaisesError [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 20
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'. 'xwing' }
		         andDice: { aLoadedDie }.

	aGame
		play;
		play.

	self
		should: [
				aGame
					useCancellationCard: 'cancellation1'
					fromShip: 'xwing'
					toTargetCard: 'speed1' ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals:
					'Cannot use cancellation card, there are no permanent cards in effect' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test61WhenCancellationCardTargetsACardNotAffectingAnyShipThenErrorIsRaised [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 20
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'. 'xwing' }
		         andDice: { aLoadedDie }.

	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'xwing';
		play;
		play.

	self
		should: [
				aGame
					useCancellationCard: 'cancellation1'
					fromShip: 'xwing'
					toTargetCard: 'overload2' ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals:
					'Cannot use cancellation card on a card that isnt in effect' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test62WhenShipHasTwoStackedEffectsOfSameTypeThenCancellationRemovesOnlyTheTargetedInstance [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 30
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'. 'xwing' }
		         andDice: { aLoadedDie }.

	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'xwing';
		play;
		play;
		useCard: 'overload2' fromShip: 'tie fighter' toShip: 'xwing';
		play;
		play.

	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: { 'overload1'. 'overload2' } asOrderedCollection.
	self assert: (aGame shipPosition: 'xwing') equals: 4.

	aGame
		useCancellationCard: 'cancellation1'
		fromShip: 'xwing'
		toTargetCard: 'overload1'.

	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: { 'overload2' } asOrderedCollection.

	aGame
		play;
		play.

	self assert: (aGame shipPosition: 'xwing') equals: 5
]

{ #category : 'tests' }
SpaceRaceTests >> test63WhenCancellationCardIsUsedThenOverloadEffectIsRemovedFromShipAffected [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 20
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'. 'xwing' }
		         andDice: { aLoadedDie }.

	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'xwing';
		play;
		play.

	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: { 'overload1' } asOrderedCollection.
	self assert: (aGame shipPosition: 'xwing') equals: 5.

	aGame
		useCancellationCard: 'cancellation1'
		fromShip: 'xwing'
		toTargetCard: 'overload1'.

	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: {  } asOrderedCollection.

	aGame
		play;
		play.
	self assert: (aGame shipPosition: 'xwing') equals: 8
]

{ #category : 'tests' }
SpaceRaceTests >> test64WhenCancellationCardIsUsedThenSpeedEffectIsRemovedFromShipAffected [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'speed'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 20
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'. 'xwing' }
		         andDice: { aLoadedDie }.

	aGame
		play;
		"tie fighter: 1 -> 4, recibe 'speed1'"play;
		"xwing: 1 -> 4, recibe 'cancellation1'"useCard: 'speed1'
		fromShip: 'tie fighter'
		toShip: 'xwing';
		play;
		"tie fighter: 4 -> 7, recibe 'speed2'"play. "xwing: 4 + 3 + 1(speed) = 8, recibe 'cancellation2'"

	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: { 'speed1' } asOrderedCollection.
	self assert: (aGame shipPosition: 'xwing') equals: 8.

	aGame
		useCancellationCard: 'cancellation1'
		fromShip: 'xwing'
		toTargetCard: 'speed1'.

	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: {  } asOrderedCollection.

	aGame
		play;
		play.

	self assert: (aGame shipPosition: 'xwing') equals: 11
]

{ #category : 'tests' }
SpaceRaceTests >> test65WhenCancellationCardIsUsedThenAccelerationEffectIsRemovedOnlyFromShipAffected [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'acceleration'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 20
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter'. 'xwing' }
		         andDice: { aLoadedDie }.

	aGame
		play;
		play;
		useCard: 'acceleration1' fromShip: 'tie fighter' toShip: 'xwing';
		play;
		play.

	self
		assert: (aGame shipActiveCardsNames: 'tie fighter')
		equals: { 'acceleration1' } asOrderedCollection.
	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: { 'acceleration1' } asOrderedCollection.

	aGame
		useCancellationCard: 'cancellation1'
		fromShip: 'xwing'
		toTargetCard: 'acceleration1'.

	self
		assert: (aGame shipActiveCardsNames: 'xwing')
		equals: {  } asOrderedCollection.
	self
		assert: (aGame shipActiveCardsNames: 'tie fighter')
		equals: {  } asOrderedCollection.

	aGame
		play;
		play.

	self assert: (aGame shipPosition: 'tie fighter') equals: 11.
	self assert: (aGame shipPosition: 'xwing') equals: 11
]

{ #category : 'tests' }
SpaceRaceTests >> test66WhenAShipLandsOnHyperJumpTileThenTheShipCanMoveInLightYears [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 1 }.
	aTile := HyperJumpTile withParsecFactor: 100 / 8 and: {
			         { 80. 'Light years' }.
			         { 50. 'Light years' }.
			         { 20. 'Light years' } }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 8
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 'tie fighter') equals: 4
]

{ #category : 'tests' }
SpaceRaceTests >> test67WhenAShipLandsOnHyperJumpTileThenTheShipCanMoveInLightYearsAndParsecs [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 1 }.
	aTile := HyperJumpTile withParsecFactor: 100 / 16 and: {
			         { 80. 'Parsecs' }.
			         { 50. 'Light years' }.
			         { 20. 'Parsecs' } }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aTile.
	aGame := SpaceRace
		         withBoard: (Board
				          withSpaces: 25
				          andLaps: 1
				          andTileGenerator: aBoardGenerator
				          andParsecsPerTile: 100 / 6)
		         andShips: { 'millenium falcon'. 'tie fighter' }
		         andDice: { aLoadedDie }.
	aGame play. "1+ (80//6.25) = 13"
	aGame play. "1+ (50//3//6.25) = 3"
	aGame play. "13 + 1 + (20//6.25) = 17"
	aGame play. "3 + 1 + (80//6.25) = 16"
	self assert: (aGame shipPosition: 'millenium falcon') equals: 18.
	self assert: (aGame shipPosition: 'tie fighter') equals: 17
]

{ #category : 'tests' }
SpaceRaceTests >> test68WhenRedoCardUsedThenItShowsUpInCardHistory [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.
	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'x-wing'.
	self assert: (aGame cardHistoryNames) equals: { 'overload1' }asOrderedCollection.
	aGame
		play.
	aGame
		useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'tie fighter' ifCancellingCancel: 'overload1';
		play.
		
	self assert: (aGame cardHistoryNames) equals: { 'overload1'. 'redo1' }asOrderedCollection 
]

{ #category : 'tests' }
SpaceRaceTests >> test69WhenRedoCardIsUsedButNoCardHasBeenUsedBeforeThenItThrowsError [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.
	aGame
		play;
		play;
		play.
		
    self
        should: [ aGame useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'tie fighter' ifCancellingCancel: 'overload1' ]
        raise: Error
        withExceptionDo: [ :error |
            self assert: error messageText equals: 'Cannot use redo card, no cards have been played yet' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test70WhenRedoAffectsAShipThenItsBehaviourIsChanged [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.
	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'x-wing';
		play;
		useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'tie fighter' ifCancellingCancel: 'overload1';
		play;
		play.
		
	self assert: (aGame shipPosition: 'tie fighter') equals: 8.
]

{ #category : 'tests' }
SpaceRaceTests >> test71WhenRedoTargetsAPermanentCardThenItShouldOnlyBePlayedInShipsTurn [
	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.
	aGame
		play;
		play.
	
		self
		should: [ aGame useCard: 'overload1' fromShip: 'tie fighter' toShip: 'x-wing';
		useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'tie fighter' ifCancellingCancel: 'overload1']
		raise: Error
		withExceptionDo: [ :arg1 |
				self
					assert: arg1 messageText
					equals: 'Ship cant use permanent card outside its turn' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test72WhenRedoCardUsedTargetingAPermanentCardThenItShowsUpInAffectedShipActiveCards [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.
		
	    
	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'x-wing';
		play;
		useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'tie fighter' ifCancellingCancel: 'overload1';
		play.
		
	self assert: (aGame shipActiveCardsNames: 'tie fighter') equals: { 'redo1' } asOrderedCollection 
]

{ #category : 'tests' }
SpaceRaceTests >> test73WhenRedoTargetsAnInstantCardThenItCanBePlayedOutsideShipsTurn [
		| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame
		play;
		play;
		useRepeatCard: 'repeat2' fromShip: 'x-wing' toShip: 'tie fighter'.

	self assert: (aGame selectShip: 'x-wing') hand size equals: 2.
	self assert: (aGame selectShip: 'tie fighter') hand size equals: 4
]

{ #category : 'tests' }
SpaceRaceTests >> test74WhenRedoTargetsSpeedThenShipAffectedByRedoAddsOneToItsRoll [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'speed'. 'redo' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.
	aGame
		play;
		play;
		useCard: 'speed1' fromShip: 'tie fighter' toShip: 'x-wing';
		play;
		useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'tie fighter' ifCancellingCancel: 'speed1';
		play;
		play.
	self assert: (aGame shipPosition: 'tie fighter') equals: 11
]

{ #category : 'tests' }
SpaceRaceTests >> test75WhenRedoTargetsAccelerationThenAllShipsRollOneMore [
	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'acceleration'. 'redo' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.
	aGame
		play;
		play;
		useCard: 'acceleration1' fromShip: 'tie fighter' toShip: 'x-wing';
		play;
		useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'all' ifCancellingCancel: 'acceleration1';
		play;
		play;
		play.
	self assert: (aGame shipPosition: 'tie fighter') equals: 13.
	self assert: (aGame shipPosition: 'x-wing') equals: 14
]

{ #category : 'tests' }
SpaceRaceTests >> test76WhenRedoTargetsARedoThenTheOriginalEffectIsAppliedAgain [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'x-wing';
		play;
		useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'tie fighter' ifCancellingCancel: 'overload1';
		play;
		play;
		useRedoCard: 'redo2' fromShip: 'x-wing' toShip: 'tie fighter' ifCancellingCancel: 'overload1';
		play;
		play.

	self assert: (aGame shipPosition: 'tie fighter') equals: 7.
	self assert: (aGame cardHistoryNames) equals: { 'overload1'. 'redo1'. 'redo2' } asOrderedCollection
]

{ #category : 'tests' }
SpaceRaceTests >> test77WhenRedoTargetsCancellationWithDifferentCardThenThatCardIsRemoved [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'speed'. 'cancellation'. 'redo' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame
		play;
		play;
		useCard: 'overload1' fromShip: 'tie fighter' toShip: 'tie fighter';
		play;
		useCard: 'speed1' fromShip: 'x-wing' toShip: 'tie fighter';
		useCancellationCard: 'cancellation1' fromShip: 'tie fighter' toTargetCard: 'overload1';
		play.

	aGame
		useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'tie fighter' ifCancellingCancel: 'speed1'.

	self assert: (aGame shipActiveCardsNames: 'tie fighter') equals: { } asOrderedCollection.
	self assert: (aGame cardHistoryNames) equals: { 'overload1'. 'speed1'. 'cancellation1'. 'redo1' } asOrderedCollection
]

{ #category : 'tests' }
SpaceRaceTests >> test78WhenRedoCardIsUsedIfCancellingCancelButNoCardHasBeenUsedBeforeThenItThrowsError [ 

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame
		play;
		play;
		play.

	self
		should: [ aGame useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'tie fighter' ifCancellingCancel: 'overload1' ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'Cannot use redo card, no cards have been played yet' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test79WhenCancellationTargetsARedoOfSpeedThenItsEffectIsRemoved [ 

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'speed'. 'redo'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame
		play;
		play;
		useCard: 'speed1' fromShip: 'tie fighter' toShip: 'x-wing';
		play;
		useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'x-wing' ifCancellingCancel: 'speed1';
		useCancellationCard: 'cancellation1' fromShip: 'tie fighter' toTargetCard: 'redo1'.

	self assert: (aGame shipActiveCardsNames: 'x-wing') equals: { 'speed1' } asOrderedCollection.
	self assert: (aGame cardHistoryNames) equals: { 'speed1'. 'redo1'. 'cancellation1' } asOrderedCollection
]

{ #category : 'tests' }
SpaceRaceTests >> test80WhenCancellationTargetsARedoOfAccelerationThenItsEffectIsRemovedFromAllShips [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'acceleration'. 'redo'. 'cancellation' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame
		play;
		play;
		useCard: 'acceleration1' fromShip: 'tie fighter' toShip: 'x-wing';
		play;
		useRedoCard: 'redo1' fromShip: 'x-wing' toShip: 'x-wing' ifCancellingCancel: 'acceleration1';
		useCancellationCard: 'cancellation1' fromShip: 'tie fighter' toTargetCard: 'redo1'.

	self assert: (aGame shipActiveCardsNames: 'tie fighter') equals: { 'acceleration1' } asOrderedCollection.
	self assert: (aGame shipActiveCardsNames: 'x-wing') equals: { 'acceleration1' } asOrderedCollection.
	self assert: (aGame cardHistoryNames) equals: { 'acceleration1'. 'redo1'. 'cancellation1' } asOrderedCollection
]

{ #category : 'tests' }
SpaceRaceTests >> test81WhenLastTileUsedIsABasicTileThenRepeatCardDoesntApplyEffect [

    | aGame aDie aCardTile aBoardGenerator aWormHoleTile |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aBoardGenerator := PredefinedTileGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.
    aGame play.
    aGame play.
    aGame useRepeatCard: 'repeat1' fromShip: 'tie fighter' toShip:'x-wing'.
    self assert: (aGame shipPosition: 'tie fighter') equals: 4.
    self assert: (aGame shipPosition: 'x-wing') equals: 4
]

{ #category : 'tests' }
SpaceRaceTests >> test82WhenLastTileUsedIsAWormHoleTileThenRepeatCardMovesChosenShipBack [
	| aGame aDie aCardTile aWormHoleTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aWormHoleTile := WormHoleTile new.
	aBoardGenerator := PredefinedTileGenerator withTileTypes: { aWormHoleTile. aCardTile. }.
	aGame := SpaceRace
                 withBoard: (Board withSpaces: 15 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame play; play; play.

	aGame useRepeatCard: 'repeat1' fromShip: 'tie fighter' toShip: 'x-wing'.

	self assert: (aGame shipPosition: 'tie fighter') equals: 1.
	self assert: (aGame shipPosition: 'x-wing') equals: 1

]

{ #category : 'tests' }
SpaceRaceTests >> test83WhenLastTileUsedIsASpeedUpTileThenRepeatCardMovesChosenShipForward [
	| aGame aDie aCardTile aSpeedUpTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aSpeedUpTile := SpeedUpTile new.
	aBoardGenerator := PredefinedTileGenerator withTileTypes: { aSpeedUpTile. aCardTile. }.
	aGame := SpaceRace
                 withBoard: (Board withSpaces: 15 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame play; play; play.

	aGame useRepeatCard: 'repeat1' fromShip: 'tie fighter' toShip: 'x-wing'.

	self assert: (aGame shipPosition: 'tie fighter') equals: 7.
	self assert: (aGame shipPosition: 'x-wing') equals: 6

]

{ #category : 'tests' }
SpaceRaceTests >> test84WhenLastTileUsedIsAMoonWalkTileThenRepeatCardMovesOtherShipsBack [
	| aGame aDie aCardTile aMoonWalkTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aMoonWalkTile := MoonWalkTile withAmountBack: 1.
	aBoardGenerator := PredefinedTileGenerator withTileTypes: { aCardTile. aCardTile. aMoonWalkTile. }.
	aGame := SpaceRace
                 withBoard: (Board withSpaces: 15 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame play; play; play.

	aGame useRepeatCard: 'repeat1' fromShip: 'tie fighter' toShip: 'x-wing'.

	self assert: (aGame shipPosition: 'tie fighter') equals: 2.
	self assert: (aGame shipPosition: 'x-wing') equals: 1

]

{ #category : 'tests' }
SpaceRaceTests >> test85WhenLastTileUsedIsAnAtomicBombTileThenRepeatCardResetsAllShips [
	| aGame aDie aCardTile aBombTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aBombTile := AtomicBombTile new.
	aBoardGenerator := PredefinedTileGenerator withTileTypes: { aBombTile. aCardTile. }.
	aGame := SpaceRace
                 withBoard: (Board withSpaces: 15 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame play; play; play.

	aGame useRepeatCard: 'repeat1' fromShip: 'tie fighter' toShip: 'x-wing'.

	self assert: (aGame shipPosition: 'tie fighter') equals: 1.
	self assert: (aGame shipPosition: 'x-wing') equals: 1

]

{ #category : 'tests' }
SpaceRaceTests >> test86WhenLastTileUsedIsACardTileThenRepeatCardGivesChosenShipANewCard [ 
	| aGame aDie aCardTile aBasicTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aBasicTile := NoEffectTile new.
	aBoardGenerator := PredefinedTileGenerator withTileTypes: { aBasicTile. aCardTile. }.
	aGame := SpaceRace
                 withBoard: (Board withSpaces: 15 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame play; play.

	aGame useRepeatCard: 'repeat1' fromShip: 'tie fighter' toShip: 'x-wing'.

	self assert: (aGame selectShip: 'tie fighter') hand size equals: 2.
	self assert: (aGame selectShip: 'x-wing') hand size equals: 4

]

{ #category : 'tests' }
SpaceRaceTests >> test87WhenLastTileUsedIsAHyperJumpTileThenRepeatCardMovesChosenShip [
	| aGame aDie aCardTile aHyperJumpTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aHyperJumpTile := HyperJumpTile withParsecFactor: 100 / 6 and: { { 2. 'Tiles' } }.
	aBoardGenerator := PredefinedTileGenerator withTileTypes: { aHyperJumpTile. aCardTile. }.
	aGame := SpaceRace
                 withBoard: (Board withSpaces: 15 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame play; play; play.

	aGame useRepeatCard: 'repeat1' fromShip: 'tie fighter' toShip: 'x-wing'.

	self assert: (aGame shipPosition: 'tie fighter') equals: 5.
	self assert: (aGame shipPosition: 'x-wing') equals: 4

]
