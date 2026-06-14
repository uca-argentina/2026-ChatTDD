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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon' } andDice: {aLoadedDie }.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test02WhenShipPassesFinishLineTheGameHasEnded [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon' } andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test03WhenTheShipMovesButDoesntCrossFinishLineThenTheGameDoesNotEnd [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon' } andDice: {aLoadedDie }.
	aGame play.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test04WhenBoardLengthIsZeroThenGameNotCreated [

	| aBoard aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile:= BasicTile new.   
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	
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
	aTile:= BasicTile new.   
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	self assert: (aGame amountOfShips) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test07WhenTwoShipsAreMovedThenBothShipsChangePosition [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	aBoard := Board withSpaces: 7 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'maty'. 'lu'. 'teo'. 'eddie' } andDice: {aLoadedDie }.
	self assert: aGame amountOfShips equals: 4.
]

{ #category : 'tests' }
SpaceRaceTests >> test12WhenTheOnlyPlayerWinsThenThePlayerIsTheWinner [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon' } andDice: {aLoadedDie }.
	aGame play.
	self assert: aGame winner equals: 'millenium falcon'.
]

{ #category : 'tests' }
SpaceRaceTests >> test13WhenTheGameIsntFinishedThenThereIsNoWinner [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	aBoard := Board withSpaces: 5 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/5.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'tie fighter' } andDice: {aLoadedDie }.

	aGame play.
	self assert: aGame finalPositions equals: { { 'tie fighter'. 1. 5 } }
]

{ #category : 'tests' }
SpaceRaceTests >> test19WhenGameWithMultiplePlayersEndsThenReturnsEachPlayerFinalPosition [

	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {5. 0}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test23WhenShip1PlaysThenItsShip2sTurn [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {4.}.
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	aBoard := Board withSpaces: 10 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100/10.
   	aGame:= SpaceRace withBoard: aBoard andShips: { 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
    aGame play.  "juega nave 1, mueve 3"
    aGame play.  "juega nave 2, mueve 4"
    self assert: (aGame shipPosition: 'millenium falcon') equals: 5.
    self assert: (aGame shipPosition: 'tie fighter') equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test24WhenShipLandsOnSpeedUpAndMovesToAnotherSpeedUpTheEffectsDontStack [
	|aGame aLoadedDie aTile aBoardGenerator aBoard|
	aLoadedDie := LoadedDie thatRolls: {2.}.
	aTile := SpeedUpTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test28WhenSecondShipLandsOnMoonWalkTideThenTheOtherShipsMoveBackNTiles [

	| aGame aLoadedDie aTile anAmountBack aBoardGenerator |
	anAmountBack := 1.
	aLoadedDie := LoadedDie thatRolls: { 2 }.
	aTile := MoonWalkTile withAmountBack: anAmountBack.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test29WhenAShipLandsOnAtomicBombTIleThenAllShipsGoBackToTheStart [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 6 }.
	aTile := AtomicBombTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.

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
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test37WhenTheAmountOfLapsInAGameIsLessThan1ThenGameCannotBeCreated [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test38WhenAShipCompletesALapItsLapIncrements [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test39WhenAShipCompletesALapThenItReturnsToFirstTile [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test40WhenShipIsOnLastLapItCannotGoBeyondLastTile [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 8 }.
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test41WhenShipFallsOnAtomicBombThenLapsAreKept [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 7 }.
	aTile := AtomicBombTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test42WhenShip1IsAheadInLapsThenItIsFirstInRanking [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5. 1 }.
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test43WhenShipOnLap2LandsOnWormHoleThenItCanGoToPreviousLap [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := WormHoleTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test44WhenShipLandsOnMoonWalkThenOtherShipsCanGoToPreviousLap [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile := MoonWalkTile withAmountBack: 4.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test45WhenUsingBoardConstructorBasicTileAppearsBetween35And45Percent [

	| constructor tiles cantidadBasic ratio |
	constructor := TileGenerator new.
	tiles := (1 to: 10000) collect: [:_ | constructor generateTileWithParsecFactor: (100/8)].
	cantidadBasic := (tiles select: [:t | t isKindOf: BasicTile]) size.
	ratio := cantidadBasic / 10000.
	self assert: (ratio between: 0.38 and: 0.42).
]

{ #category : 'tests' }
SpaceRaceTests >> test46WhenUsingBoardConstructorSpeedUpTileAppearsBetween15And25Percent [

	| constructor tiles cantidadSpeedUp ratio |
	constructor := TileGenerator new.
	tiles := (1 to: 10000) collect: [:_ | constructor generateTileWithParsecFactor: (100/8)].
	cantidadSpeedUp := (tiles select: [:t | t isKindOf: SpeedUpTile ]) size.
	ratio := cantidadSpeedUp / 10000.
	self assert: (ratio between: 0.18 and: 0.22).
]

{ #category : 'tests' }
SpaceRaceTests >> test47WhenUsingBoardConstructorTilesAppearBetweenExpectedValues [
    | constructor tiles counts total |
	constructor := TileGenerator new.
    tiles := (1 to: 10000) collect: [:_ | constructor generateTileWithParsecFactor: (100/8)].
    total := tiles size.
    
    counts := Dictionary new.
    counts at: BasicTile      put: (tiles select: [:t | t isKindOf: BasicTile]) size.
    counts at: WormHoleTile   put: (tiles select: [:t | t isKindOf: WormHoleTile]) size.
    counts at: SpeedUpTile    put: (tiles select: [:t | t isKindOf: SpeedUpTile]) size.
    counts at: MoonWalkTile   put: (tiles select: [:t | t isKindOf: MoonWalkTile]) size.
    counts at: HyperJumpTile  put: (tiles select: [:t | t isKindOf: HyperJumpTile]) size.
    counts at: AtomicBombTile put: (tiles select: [:t | t isKindOf: AtomicBombTile]) size.
    
    "Verificamos que todos los porcentajes estén dentro del rango esperado"
    {
        { BasicTile.      0.38. 0.42 }.
        { WormHoleTile.   0.18. 0.22 }.
        { SpeedUpTile.    0.18. 0.22 }.
        { MoonWalkTile.   0.08. 0.12 }.
        { HyperJumpTile.  0.06. 0.10 }.
        { AtomicBombTile. 0.00. 0.04 }.
    } do: [:entry |
        | tileClass min max ratio |
        tileClass := entry at: 1.
        min       := entry at: 2.
        max       := entry at: 3.
        ratio     := (counts at: tileClass) / total.
        self assert: (ratio between: min and: max)
		]
]

{ #category : 'tests' }
SpaceRaceTests >> test48WhenShipIsCreatedThenItStartsWithTwoCards [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp2 := LoadedDie thatRolls: { 3 }.
	tmp5 := Card new.
	tmp3 := BasicTile new.
	tmp4 := HardcodedBoardGenerator withTileType: tmp3.
	tmp1 := SpaceRace
		        withBoard: (Board
				         withSpaces: 5
				         andLaps: 1
				         andTileGenerator: tmp4
				         andParsecsPerTile: 100 / 6)
		        andShips: { 'tie fighter' }
		        andDice: { tmp2 }.
	self assert: (tmp1 shipsHand: 'tie fighter') size equals: 2
]

{ #category : 'tests' }
SpaceRaceTests >> test49WhenShipLandsOnCardTileThenItReceivesACard [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp2 := LoadedDie thatRolls: { 3 }.
	tmp5 := Card new.
	tmp3 := CardTile default.
	tmp4 := HardcodedBoardGenerator withTileType: tmp3.
	tmp1 := SpaceRace
		        withBoard: (Board
				         withSpaces: 5
				         andLaps: 1
				         andTileGenerator: tmp4
				         andParsecsPerTile: 100 / 6)
		        andShips: { 'tie fighter' }
		        andDice: { tmp2 }.
	tmp1 play.
	self assert: (tmp1 shipsHand: 'tie fighter') size equals: 3
]

{ #category : 'tests' }
SpaceRaceTests >> test50WhenShipUsesCardThenItsDeletedFromItsHand [

	| aGame aLoadedDie aTile aBoardGenerator overload |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	overload := OverloadCard new.
	aTile := HardcodedCardTile thatGives: { 'overload' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test51WhenAShipTriesToUseACardThatIsntInItsHandThenItThrowsError [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp2 := LoadedDie thatRolls: { 3 }.
	tmp5 := OverloadCard new.
	tmp3 := BasicTile new.
	tmp4 := HardcodedBoardGenerator withTileType: tmp3.
	tmp1 := SpaceRace
		        withBoard: (Board
				         withSpaces: 5
				         andLaps: 1
				         andTileGenerator: tmp4
				         andParsecsPerTile: 100 / 6)
		        andShips: { 'tie fighter' }
		        andDice: { tmp2 }.
	tmp1 play.
	self
		should: [
		tmp1 useCard: tmp5 fromShip: 'tie fighter' toShip: 'tie fighter' ]
		raise: Error
		withExceptionDo: [ :arg1 |
				self
					assert: arg1 messageText
					equals: 'Cant use card that isnt in your hand' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test52WhenACardIsUsedThenTheGamesCardHistoryAddsIt [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test53WhenAShipTriesToUseAPermanentCardOutsideItsTurnThenItIsNotAllowed [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test55WhenOverloadCardMakesShipGoesBackwardsThenShipGoesBackInSpaces [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 0 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
	self assert: (aGame shipPosition: 'tie fighter') equals: 1
]

{ #category : 'tests' }
SpaceRaceTests >> test56WhenSpeedCardAppliedThenShipAffectedMovesOneSpaceMore [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'speed' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test57WhenAccelerationCardUsedThenAllShipsMove1SpaceMore [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'acceleration' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test58WhenInstantCardIsUsedOutsideShipsTurnThenItIsAppliedAnyways [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test59WhenInstantCardIsUsedThenItDoesntShowUpInActiveCards [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test60WhenCancellationCardUsedThenASelectedPermanentEffectIsRemovedFromShipAffected [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test61WhenCancellationCardIsUsedButThereAreNotAnyPermanentsThenItRaisesError [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test62WhenCancellationCardTargetsACardNotAffectingAnyShipThenErrorIsRaised [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test63WhenShipHasTwoStackedEffectsOfSameTypeThenCancellationRemovesOnlyTheTargetedInstance [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test64WhenCancellationCardIsUsedThenOverloadEffectIsRemovedFromShipAffected [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'overload'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test65WhenCancellationCardIsUsedThenSpeedEffectIsRemovedFromShipAffected [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'speed'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test66WhenCancellationCardIsUsedThenAccelerationEffectIsRemovedOnlyFromShipAffected [

	| aGame aLoadedDie aCardTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives:
		             { 'acceleration'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test67WhenAShipLandsOnHyperJumpTileThenTheShipCanMoveInLightYears [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 1 }.
	aTile := HyperJumpTile withParsecFactor: 100 / 8 and: {
			         { 80. 'Light years' }.
			         { 50. 'Light years' }.
			         { 20. 'Light years' } }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test68WhenAShipLandsOnHyperJumpTileThenTheShipCanMoveInLightYearsAndParsecs [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 1 }.
	aTile := HyperJumpTile withParsecFactor: 100 / 16 and: {
			         { 80. 'Parsecs' }.
			         { 50. 'Light years' }.
			         { 20. 'Parsecs' } }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
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
SpaceRaceTests >> test69WhenRedoCardUsedThenItShowsUpInCardHistory [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test70WhenRedoCardIsUsedButNoCardHasBeenUsedBeforeThenItThrowsError [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test71WhenRedoAffectsAShipThenItsBehaviourIsChanged [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test72WhenRedoTargetsAPermanentCardThenItShouldOnlyBePlayedInShipsTurn [
	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test73WhenRedoCardUsedTargetingAPermanentCardThenItShowsUpInAffectedShipActiveCards [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test74WhenRedoTargetsAnInstantCardThenItCanBePlayedOutsideShipsTurn [
		| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test75WhenRedoTargetsSpeedThenShipAffectedByRedoAddsOneToItsRoll [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'speed'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test76WhenRedoTargetsAccelerationThenAllShipsRollOneMore [
	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'acceleration'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test77WhenRedoTargetsARedoThenTheOriginalEffectIsAppliedAgain [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test78WhenRedoTargetsCancellationWithDifferentCardThenThatCardIsRemoved [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'speed'. 'cancellation'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test79WhenRedoTargetsCancellationWithDifferentCardThenThatCardIsRemoved [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'speed'. 'cancellation'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test80WhenRedoCardIsUsedIfCancellingCancelButNoCardHasBeenUsedBeforeThenItThrowsError [ 

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'overload'. 'redo' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test81WhenCancellationTargetsARedoOfSpeedThenItsEffectIsRemoved [ 

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'speed'. 'redo'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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
SpaceRaceTests >> test82WhenCancellationTargetsARedoOfAccelerationThenItsEffectIsRemovedFromAllShips [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'acceleration'. 'redo'. 'cancellation' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
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

{ #category : 'as yet unclassified' }
SpaceRaceTests >> test83WhenNobodyRollDiceThenRepeatCardDoesntApplyEffect [

	| aGame aDie aCardTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 3 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aCardTile.
	aGame := SpaceRace
                 withBoard: (Board
                          withSpaces: 15
                          andLaps: 1
                          andTileGenerator: aBoardGenerator
                          andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

    aGame useRepeatCard: 'repeat1' fromShip: 'tie fighter' toShip: 'tie fighter'.
    self assert: (aGame shipPosition: 'tie fighter') equals: 1.
    self assert: (aGame shipPosition: 'x wing') equals: 1.
]

{ #category : 'tests' }
SpaceRaceTests >> test84WhenLastTileUsedIsABasicTileThenRepeatCardDoesntApplyEffect [

   | aGame aDie aCardTile aBasicTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aBasicTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileTypes: { aBasicTile. aCardTile. }.
	aGame := SpaceRace
                 withBoard: (Board withSpaces: 15 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame play; play; play.

	aGame useRepeatCard: 'repeat1' fromShip: 'tie fighter' toShip: 'x-wing'.

	self assert: (aGame shipPosition: 'tie fighter') equals: 3.
	self assert: (aGame shipPosition: 'x-wing') equals: 2
]

{ #category : 'tests' }
SpaceRaceTests >> test85WhenLastTileUsedIsAWormHoleTileThenRepeatCardMovesChosenShipBack [
	| aGame aDie aCardTile aWormHoleTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aWormHoleTile := WormHoleTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileTypes: { aWormHoleTile. aCardTile. }.
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
SpaceRaceTests >> test86WhenLastTileUsedIsASpeedUpTileThenRepeatCardMovesChosenShipForward [
	| aGame aDie aCardTile aSpeedUpTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aSpeedUpTile := SpeedUpTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileTypes: { aSpeedUpTile. aCardTile. }.
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
SpaceRaceTests >> test87WhenLastTileUsedIsAMoonWalkTileThenRepeatCardMovesOtherShipsBack [
	| aGame aDie aCardTile aMoonWalkTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aMoonWalkTile := MoonWalkTile withAmountBack: 1.
	aBoardGenerator := HardcodedBoardGenerator withTileTypes: { aCardTile. aCardTile. aMoonWalkTile. }.
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
SpaceRaceTests >> test88WhenLastTileUsedIsAnAtomicBombTileThenRepeatCardResetsAllShips [
	| aGame aDie aCardTile aBombTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aBombTile := AtomicBombTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileTypes: { aBombTile. aCardTile. }.
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
SpaceRaceTests >> test89WhenLastTileUsedIsACardTileThenRepeatCardGivesChosenShipANewCard [ 
	| aGame aDie aCardTile aBasicTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aBasicTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileTypes: { aBasicTile. aCardTile. }.
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
SpaceRaceTests >> test90WhenLastTileUsedIsAHyperJumpTileThenRepeatCardMovesChosenShip [
	| aGame aDie aCardTile aHyperJumpTile aBoardGenerator |
	aDie := LoadedDie thatRolls: { 1 }.
	aCardTile := HardcodedCardTile thatGives: { 'repeat' }.
	aHyperJumpTile := HyperJumpTile withParsecFactor: 100 / 6 and: { { 2. 'Tiles' } }.
	aBoardGenerator := HardcodedBoardGenerator withTileTypes: { aHyperJumpTile. aCardTile. }.
	aGame := SpaceRace
                 withBoard: (Board withSpaces: 15 andLaps: 1 andTileGenerator: aBoardGenerator andParsecsPerTile: 100 / 6)
                 andShips: { 'tie fighter'. 'x-wing' }
                 andDice: { aDie }.

	aGame play; play; play.

	aGame useRepeatCard: 'repeat1' fromShip: 'tie fighter' toShip: 'x-wing'.

	self assert: (aGame shipPosition: 'tie fighter') equals: 5.
	self assert: (aGame shipPosition: 'x-wing') equals: 4

]
