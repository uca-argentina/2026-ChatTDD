Class {
	#name : 'SpaceRaceTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceRaceTests >> test01WhenTheGameIsNotOverThenTheGameHasNotEnded [
	|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test02WhenShipPassesFinishLineTheGameHasEnded [
|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test03WhenTheShipMovesButDoesntCrossFinishLineThenTheGameDoesNotEnd [
	|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
	
	aGame play.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test04WhenBoardLengthIsZeroThenGameNotCreated [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile:= BasicTile new.   
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	
	self
		should: [

   		aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 0 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }. ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Board spaces cannot be less than 1' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test05WhenBoardLengthIsNegativeThenGameNotCreated [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	self
		should: [
   			aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: -3 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Board spaces cannot be less than 1' ]

]

{ #category : 'tests' }
SpaceRaceTests >> test06WhenAGameIsCreateWith2ShipsThenTheGameHas2Ships [
		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	self assert: (aGame amountOfShips) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test07WhenTwoShipsAreMovedThenBothShipsChangePosition [
		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 2)equals: 6.
]

{ #category : 'tests' }
SpaceRaceTests >> test08WhenEachShipMovesThenItMovesItsOwnAmountOfSquares [

		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 6.
	self assert: (aGame shipPosition: 2) equals: 6.
]

{ #category : 'tests' }
SpaceRaceTests >> test09WhenFirstShipWinsThenTheGameEnds [

		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test10WhenSecondShipWinsThenTheGameEnds [

		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5. 7.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test11WhenTheGameIsCreatedWith4ShipsThen4ShipsExist [

		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:4 andDice: {aLoadedDie }.
	self assert: aGame amountOfShips equals: 4.
]

{ #category : 'tests' }
SpaceRaceTests >> test12WhenTheOnlyPlayerWinsThenThePlayerIsTheWinner [
		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
	aGame play.
	self assert: aGame winner equals: 1.
]

{ #category : 'tests' }
SpaceRaceTests >> test13WhenTheGameIsntFinishedThenThereIsNoWinner [
		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
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
		
	|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {1. 7.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	
	aGame play.
	aGame play.
	self assert: aGame winner equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test15WhenSomeoneWonThenNoShipCanKeepPlaying [
		|aGame aTile aBoardGenerator |
		aTile:= BasicTile new.
		aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   		aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {(LoadedDie thatRolls: {6.})}.
		aGame play.  "la nave gana"
		self should: [ aGame play ] raise: Error
		withExceptionDo:[ :error |
			self
				assert: error messageText
				equals: 'Game is over. Ships cannot move anymore.']	
]

{ #category : 'tests' }
SpaceRaceTests >> test16WhenTheGameEndedThenFinalPositionOfShipIs5 [
		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
	aGame play.
	self assert: aGame finalPositions equals: {5} asOrderedCollection.
]

{ #category : 'tests' }
SpaceRaceTests >> test17WhenAGameIsNotOverThenFinalPositionsAreNotDefined [
	|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {3.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
	
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
		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {8.}.
	
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
	
	aGame play.
	self assert: aGame finalPositions equals: {5} asOrderedCollection .
]

{ #category : 'tests' }
SpaceRaceTests >> test19WhenGameWithMultiplePlayersEndsThenReturnsEachPlayerFinalPosition [
	|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5. 0.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	aGame play.
	self assert: aGame finalPositions equals: {5. 1} asOrderedCollection .
]

{ #category : 'tests' }
SpaceRaceTests >> test20WhenGameHasMultipleDiceThenTheShipsShouldMoveTheSumOfTheDice [

|aGame aLoadedDie anotherDie aTile aBoardGenerator |
	
    aLoadedDie := LoadedDie thatRolls: {2}.
	 anotherDie := LoadedDie thatRolls: {2}.
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 10 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie. anotherDie }.
    aGame play.
    self assert: (aGame shipPosition:1 ) equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test21WhenShipLandsOnSpeedUpTileThenItMovesForward4Tiles [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := SpeedUpTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 6 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 6. 
]

{ #category : 'tests' }
SpaceRaceTests >> test22WhenShipsEndsOnASpeedUpTileThenGameEndsAndSpeedUpIsntPlayed [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5}.
	aTile := SpeedUpTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
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
    | aGame aDie aTile aBoardGenerator |
    aDie := LoadedDie thatRolls: {4. 4.}.
	 aTile:= BasicTile new.
	 aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	 aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 10 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aDie }.
    aGame play.  "juega nave 1, mueve 3"
    aGame play.  "juega nave 2, mueve 4"
    self assert: (aGame shipPosition: 1) equals: 5.
    self assert: (aGame shipPosition: 2) equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test24WhenShipLandsOnSpeedUpAndMovesToAnotherSpeedUpTheEffectsDontStack [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := SpeedUpTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 7. 
]

{ #category : 'tests' }
SpaceRaceTests >> test25WhenShipLandsOnWormHoleTileThenItMovesBack4Tiles [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5}.
	aTile := WormHoleTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 2. 
]

{ #category : 'tests' }
SpaceRaceTests >> test26WhenShipLandsOnWormHoleTileThenItCannotGoBehindPosition0 [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := WormHoleTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 1. 
]

{ #category : 'tests' }
SpaceRaceTests >> test27WhenShipLandsOnMoonWalkTileThenShipIsntAffected [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := MoonWalkTile withAmountBack: 1.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 3. 
]

{ #category : 'tests' }
SpaceRaceTests >> test28WhenSecondShipLandsOnMoonWalkTideThenTheOtherShipsMoveBackNTiles [

	| aGame aLoadedDie aTile anAmountBack aBoardGenerator |
	anAmountBack := 1.
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := MoonWalkTile withAmountBack: anAmountBack.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:3 andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 2. 
	self assert: (aGame shipPosition: 2) equals: 3. 
	self assert: (aGame shipPosition: 3) equals: 1. 
]

{ #category : 'tests' }
SpaceRaceTests >> test29WhenAShipLandsOnAtomicBombTIleThenAllShipsGoBackToTheStart [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {6}.
	aTile := AtomicBombTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 8 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 1. 
	
]

{ #category : 'tests' }
SpaceRaceTests >> test30WhenTotalParsecsAreEqualOrLessThan0ThenSpaceRaceIsntCreated [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := HyperJumpTile withParsecFactor: 100/8.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	
	self
		should: [
   		aGame:= SpaceRace withTotalParsecs: -1 dividedInSpaces: 10 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Total parsecs cannot be equal or less than 0' ]
	
]

{ #category : 'tests' }
SpaceRaceTests >> test31WhenAShipLandsOnHyperJumpTileThenTheShipMovesInParsecs [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := HyperJumpTile withParsecFactor: 100/8.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 8 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 8. 
]

{ #category : 'tests' }
SpaceRaceTests >> test32WhenMultipleShipsLandOnHyperJumpThenJumpDistanceRotates [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := HyperJumpTile withParsecFactor: 100/16.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 25 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
	aGame play. "1+ (80//6.25) = 13"
	aGame play. "1+ (50//6.25) = 9"
	aGame play. "13 + 1 + (20//6.25) = 17"
	aGame play. "9 + 1 + (80//6.25) = 22" 
	self assert: (aGame shipPosition: 1) equals: 18. 
	self assert: (aGame shipPosition: 2) equals: 23. 
]

{ #category : 'tests' }
SpaceRaceTests >> test33WhenSecondShipIsAheadFirstOneThenSecondShipIsFirstInRanking [
    | aGame aDie aTile aBoardGenerator |
    aDie := LoadedDie thatRolls: {3. 4.}.
	 aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 8 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aDie }.
    aGame play.  
    aGame play.  
    self assert: (aGame ranking) equals: {2. 1}.
]

{ #category : 'tests' }
SpaceRaceTests >> test34WhenShipIsPassedByOtherShipThenItFallsInTheRanking [
    | aGame aDie aTile aBoardGenerator |
    aDie := LoadedDie thatRolls: {3. 4.}.
	 aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 8 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aDie }.
    aGame play.  "juega nave 1, pos 3"
    aGame play.  "juega nave 2, pos 4"
    self assert: (aGame shipRanking: 1) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test35WhenTheAmountOfLapsInAGameIsLessThan1ThenGameCannotBeCreated [
		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	self
		should: [
   		aGame:= SpaceRace withTotalParsecs: -1 dividedInSpaces: 10 andLaps: 0 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Amount of laps cannot be less than 1' ]

]

{ #category : 'tests' }
SpaceRaceTests >> test36WhenShipJustCompletesFirstLapThenTheGameHasntEnded [
		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 2 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
	aGame play.
	self deny: (aGame hasEnded).

]

{ #category : 'tests' }
SpaceRaceTests >> test37WhenTheAmountOfLapsInAGameIsLessThan1ThenGameCannotBeCreated [
		|aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	self
		should: [
   		aGame:= SpaceRace withTotalParsecs: -1 dividedInSpaces: 10 andLaps: 0 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Amount of laps cannot be less than 1' ]

]

{ #category : 'tests' }
SpaceRaceTests >> test38WhenAShipCompletesALapItsLapIncrements [
    | aGame aLoadedDie aTile aBoardGenerator |
    aLoadedDie := LoadedDie thatRolls: {5.}.
    aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 2 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
    aGame play.
    self assert: (aGame shipLap: 1) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test39WhenAShipCompletesALapThenItReturnsToFirstTile [
    | aGame aLoadedDie aTile aBoardGenerator |
    aLoadedDie := LoadedDie thatRolls: {5.}.
    aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 2 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
    aGame play.
    self assert: (aGame shipPosition: 1) equals: 1.
]

{ #category : 'tests' }
SpaceRaceTests >> test40WhenShipIsOnLastLapItCannotGoBeyondLastTile [
    | aGame aLoadedDie aTile aBoardGenerator |
    aLoadedDie := LoadedDie thatRolls: {8.}.
    aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
    aGame play.
    self assert: (aGame shipPosition: 1) equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test41WhenShipFallsOnAtomicBombThenLapsAreKept [
    | aGame aLoadedDie aTile aBoardGenerator |
    aLoadedDie := LoadedDie thatRolls: {7.}.
    aTile := AtomicBombTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 3 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
    aGame play.
    self assert: (aGame shipLap: 1) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test42WhenShip1IsAheadInLapsThenItIsFirstInRanking [
    | aGame aLoadedDie aTile aBoardGenerator |
    aLoadedDie := LoadedDie thatRolls: {5. 1.}.
    aTile := BasicTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 2 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
    aGame play. "nave 1 completa vuelta, lap=2"
    aGame play. "nave 2 avanza 1"
    self assert: aGame ranking equals: {1. 2}.
]

{ #category : 'tests' }
SpaceRaceTests >> test43WhenShipOnLap2LandsOnWormHoleThenItCanGoToPreviousLap [
    | aGame aLoadedDie aTile aBoardGenerator |
    aLoadedDie := LoadedDie thatRolls: {5.}.
    aTile := WormHoleTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 3 andBoardGenerator: aBoardGenerator andShips:1 andDice: {aLoadedDie }.
    aGame play. "lap 2 pos 1 - 4"
    self assert: (aGame shipPosition: 1) equals: 2.
    self assert: (aGame shipLap: 1) equals: 1.
]

{ #category : 'tests' }
SpaceRaceTests >> test44WhenShipLandsOnMoonWalkThenOtherShipsCanGoToPreviousLap [
    | aGame aLoadedDie aTile aBoardGenerator |
    aLoadedDie := LoadedDie thatRolls: {5.}.
    aTile := MoonWalkTile withAmountBack: 4.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 3 andBoardGenerator: aBoardGenerator andShips:2 andDice: {aLoadedDie }.
    aGame play. "nave 1 completa vuelta, lap=2 pos=1"
    aGame play. "nave 2 avanza 5 (lap=2 pos=1), cae en moonwalk -4 → nave 1 va a pos=1 lap=2"
    self assert: (aGame shipPosition: 1) equals: 2.
    self assert: (aGame shipLap: 1) equals: 1.
]

{ #category : 'tests' }
SpaceRaceTests >> test45WhenUsingBoardConstructorBasicTileAppearsBetween35And45Percent [

	| constructor tiles cantidadBasic ratio |
	constructor := BoardGenerator new.
	tiles := (1 to: 10000) collect: [:_ | constructor generateTilewithParsecFactor: (100/8)].
	cantidadBasic := (tiles select: [:t | t isKindOf: BasicTile]) size.
	ratio := cantidadBasic / 10000.
	self assert: (ratio between: 0.38 and: 0.42).
]

{ #category : 'tests' }
SpaceRaceTests >> test46WhenUsingBoardConstructorSpeedUpTileAppearsBetween15And25Percent [

	| constructor tiles cantidadSpeedUp ratio |
	constructor := BoardGenerator new.
	tiles := (1 to: 10000) collect: [:_ | constructor generateTilewithParsecFactor: (100/8)].
	cantidadSpeedUp := (tiles select: [:t | t isKindOf: SpeedUpTile ]) size.
	ratio := cantidadSpeedUp / 10000.
	self assert: (ratio between: 0.18 and: 0.22).
]

{ #category : 'tests' }
SpaceRaceTests >> test47WhenUsingBoardConstructorTilesAppearBetweenExpectedValues [
    | constructor tiles counts total |
	constructor := BoardGenerator new.
    tiles := (1 to: 10000) collect: [:_ | constructor generateTilewithParsecFactor: (100/8)].
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
