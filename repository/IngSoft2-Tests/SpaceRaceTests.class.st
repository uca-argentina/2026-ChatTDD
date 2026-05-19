Class {
	#name : 'SpaceRaceTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceRaceTests >> test01WhenTheGameIsNotOverThenTheGameHasNotEnded [
	|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andTiles: aTile andShips:1 andDice: {aLoadedDie }.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test02WhenShipPassesFinishLineTheGameHasEnded [
|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andTiles: aTile andShips:1 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test03WhenTheShipMovesButDoesntCrossFinishLineThenTheGameDoesNotEnd [
	|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:1 andDice: {aLoadedDie }.
	aGame play.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test04WhenBoardLengthIsZeroThenGameNotCreated [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile:= BasicTile new.   

	self
		should: [
		aGame := SpaceRace withTotalParsecs: 100 dividedInSpaces: 0 andTiles: aTile andShips: 1 andDice: { aLoadedDie } ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Board spaces cannot be less than 1' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test05WhenBoardLengthIsNegativeThenGameNotCreated [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: { 5 }.
	aTile:= BasicTile new.

	self
		should: [
		   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: -3 andTiles: aTile andShips:1 andDice: {aLoadedDie }.]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Board spaces cannot be less than 1' ]

]

{ #category : 'tests' }
SpaceRaceTests >> test06WhenAGameIsCreateWith2ShipsThenTheGameHas2Ships [
		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie }.
	self assert: (aGame amountOfShips) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test07WhenTwoShipsAreMovedThenBothShipsChangePosition [
		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 2)equals: 6.
]

{ #category : 'tests' }
SpaceRaceTests >> test08WhenEachShipMovesThenItMovesItsOwnAmountOfSquares [

		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 6.
	self assert: (aGame shipPosition: 2) equals: 6.
]

{ #category : 'tests' }
SpaceRaceTests >> test09WhenFirstShipWinsThenTheGameEnds [

		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test10WhenSecondShipWinsThenTheGameEnds [

		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5. 7.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie }.
	
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test11WhenTheGameIsCreatedWith4ShipsThen4ShipsExist [

		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:4 andDice: {aLoadedDie }.
	self assert: aGame amountOfShips equals: 4.
]

{ #category : 'tests' }
SpaceRaceTests >> test12WhenTheOnlyPlayerWinsThenThePlayerIsTheWinner [
		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andTiles: aTile andShips:1 andDice: {aLoadedDie }.
	aGame play.
	self assert: aGame winner equals: 1.
]

{ #category : 'tests' }
SpaceRaceTests >> test13WhenTheGameIsntFinishedThenThereIsNoWinner [
		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:1 andDice: {aLoadedDie }.
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
		
	|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {1. 7.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie }.
	
	aGame play.
	aGame play.
	self assert: aGame winner equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test15WhenSomeoneWonThenNoShipCanKeepPlaying [
		|aGame aTile |
		aTile:= BasicTile new.
   		aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andTiles: aTile andShips:1 andDice: {(LoadedDie thatRolls: {6.})}.
		aGame play.  "la nave gana"
		self should: [ aGame play ] raise: Error
		withExceptionDo:[ :error |
			self
				assert: error messageText
				equals: 'Game is over. Ships cannot move anymore.']	
]

{ #category : 'tests' }
SpaceRaceTests >> test16WhenTheGameEndedThenFinalPositionOfShipIs5 [
		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andTiles: aTile andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self assert: aGame finalPositions equals: {5} asOrderedCollection.
]

{ #category : 'tests' }
SpaceRaceTests >> test17WhenAGameIsNotOverThenFinalPositionsAreNotDefined [
	|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {3.}.
	aTile:= BasicTile new.
	
   aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andTiles: aTile andShips:1 andDice: {aLoadedDie }.
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
		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {8.}.
	
	aTile:= BasicTile new.
   aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andTiles: aTile andShips:1 andDice: {aLoadedDie}.
	
	aGame play.
	self assert: aGame finalPositions equals: {5} asOrderedCollection .
]

{ #category : 'tests' }
SpaceRaceTests >> test19WhenGameWithMultiplePlayersEndsThenReturnsEachPlayerFinalPosition [
	|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5. 0.}.
	aTile:= BasicTile new.
   aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: aGame finalPositions equals: {5. 1} asOrderedCollection .
]

{ #category : 'tests' }
SpaceRaceTests >> test20WhenGameHasMultipleDiceThenTheShipsShouldMoveTheSumOfTheDice [

|aGame aLoadedDie anotherDie aTile |
	
    aLoadedDie := LoadedDie thatRolls: {2}.
	 anotherDie := LoadedDie thatRolls: {2}.
	aTile := BasicTile new.
    aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 10 andTiles: aTile andShips:1 andDice: {aLoadedDie. anotherDie. }.
    aGame play.
    self assert: (aGame shipPosition:1 ) equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test21WhenShipLandsOnSpeedUpTileThenItMovesForward4Tiles [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := SpeedUpTile new.
   aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 6 andTiles: aTile andShips:2 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 6. 
]

{ #category : 'tests' }
SpaceRaceTests >> test22WhenShipsEndsOnASpeedUpTileThenGameEndsAndSpeedUpIsntPlayed [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5}.
	aTile := SpeedUpTile new.
   aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
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
    | aGame aDie aTile |
    aDie := LoadedDie thatRolls: {4. 4.}.
	 aTile:= BasicTile new.
    aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 10 andTiles: aTile andShips:2 andDice: {aDie}.
    aGame play.  "juega nave 1, mueve 3"
    aGame play.  "juega nave 2, mueve 4"
    self assert: (aGame shipPosition: 1) equals: 5.
    self assert: (aGame shipPosition: 2) equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test24WhenShipLandsOnSpeedUpAndMovesToAnotherSpeedUpTheEffectsDontStack [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := SpeedUpTile new.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 7. 
]

{ #category : 'tests' }
SpaceRaceTests >> test25WhenShipLandsOnWormHoleTileThenItMovesBack4Tiles [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {5}.
	aTile := WormHoleTile new.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 2. 
]

{ #category : 'tests' }
SpaceRaceTests >> test26WhenShipLandsOnWormHoleTileThenItCannotGoBehindPosition0 [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := WormHoleTile new.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 1. 
]

{ #category : 'tests' }
SpaceRaceTests >> test27WhenShipLandsOnMoonWalkTileThenShipIsntAffected [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := MoonWalkTile withAmountBack: 1.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 3. 
]

{ #category : 'tests' }
SpaceRaceTests >> test28WhenSecondShipLandsOnMoonWalkTideThenTheOtherShipsMoveBackNTiles [

	| aGame aLoadedDie aTile anAmountBack |
	anAmountBack := 1.
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := MoonWalkTile withAmountBack: anAmountBack.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:3 andDice: {aLoadedDie}.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 2. 
	self assert: (aGame shipPosition: 2) equals: 3. 
	self assert: (aGame shipPosition: 3) equals: 1. 
]

{ #category : 'tests' }
SpaceRaceTests >> test29WhenAShipLandsOnAtomicBombTIleThenAllShipsGoBackToTheStart [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {6}.
	aTile := AtomicBombTile new.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 8 andTiles: aTile andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 1. 
	
]

{ #category : 'tests' }
SpaceRaceTests >> test30WhenTotalParsecsAreEqualOrLessThan0ThenSpaceRaceIsntCreated [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := HyperJumpTile withParsecFactor: 100/8.
	
	self
		should: [
		aGame:= SpaceRace withTotalParsecs: -1 dividedInSpaces: 10 andTiles: aTile andShips:1 andDice: {aLoadedDie}.]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Total parsecs cannot be equal or less than 0' ]
	
]

{ #category : 'tests' }
SpaceRaceTests >> test31WhenAShipLandsOnHyperJumpTileThenTheShipMovesInParsecs [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := HyperJumpTile withParsecFactor: 100/8.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 8 andTiles: aTile andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 8. 
]

{ #category : 'tests' }
SpaceRaceTests >> test32WhenMultipleShipsLandOnHyperJumpThenJumpDistanceRotates [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := HyperJumpTile withParsecFactor: 100/16.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 25 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play. "1+ (80//6.25) = 13"
	aGame play. "1+ (50//6.25) = 9"
	aGame play. "13 + 1 + (20//6.25) = 17"
	aGame play. "9 + 1 + (80//6.25) = 22" 
	self assert: (aGame shipPosition: 1) equals: 18. 
	self assert: (aGame shipPosition: 2) equals: 23. 
]

{ #category : 'tests' }
SpaceRaceTests >> test33WhenSecondShipIsAheadFirstOneThenSecondShipIsFirstInRanking [
    | aGame aDie aTile |
    aDie := LoadedDie thatRolls: {3. 4.}.
	 aTile := BasicTile new.
	 aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 8 andTiles: aTile andShips:2 andDice: {aDie}.
    aGame play.  
    aGame play.  
    self assert: (aGame ranking) equals: {2. 1}.
]

{ #category : 'tests' }
SpaceRaceTests >> test34WhenShipIsPassedByOtherShipThenItFallsInTheRanking [
    | aGame aDie aTile |
    aDie := LoadedDie thatRolls: {3. 4.}.
	 aTile := BasicTile new.
	 aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 8 andTiles: aTile andShips:2 andDice: {aDie}.
    aGame play.  "juega nave 1, pos 3"
    aGame play.  "juega nave 2, pos 4"
    self assert: (aGame shipRanking: 1) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test34WhenShipJustCompletesFirstLapThenTheGameHasntEnded [
		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile := BasicTile new.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 2 andTiles: aTile andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self deny: (aGame hasEnded).

]

{ #category : 'tests' }
SpaceRaceTests >> test35WhenTheAmountOfLapsInAGameIsLessThan1ThenGameCannotBeCreated [
		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
	self
		should: [
		aGame:= SpaceRace withTotalParsecs: -1 dividedInSpaces: 10 andLaps: 0 andTiles: aTile andShips:1 andDice: {aLoadedDie}.]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Amount of laps cannot be less than 1' ]

]

{ #category : 'tests' }
SpaceRaceTests >> test36WhenAShipCompletesALapThenItReturnsToFirstCell [
    | aGame aLoadedDie aTile |
    aLoadedDie := LoadedDie thatRolls: {5.}.
    aTile := BasicTile new.
    aGame := SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 2 andTiles: aTile andShips: 1 andDice: {aLoadedDie}.
    aGame play.
    self assert: (aGame shipPosition: 1) equals: 1.
]

{ #category : 'tests' }
SpaceRaceTests >> test37WhenAShipCompletesALapItsLapIncrements [
    | aGame aLoadedDie aTile |
    aLoadedDie := LoadedDie thatRolls: {5.}.
    aTile := BasicTile new.
    aGame := SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 2 andTiles: aTile andShips: 1 andDice: {aLoadedDie}.
    aGame play.
    self assert: (aGame shipLap: 1) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test38WhenShipIsOnLastLapItCannotGoBeyondLastCell [
    | aGame aLoadedDie aTile |
    aLoadedDie := LoadedDie thatRolls: {8.}.
    aTile := BasicTile new.
    aGame := SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 1 andTiles: aTile andShips: 1 andDice: {aLoadedDie}.
    aGame play.
    self assert: (aGame shipPosition: 1) equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test39WhenShipFallsOnAtomicBombThenLapsAreKept [
    | aGame aLoadedDie aTile |
    aLoadedDie := LoadedDie thatRolls: {7.}.
    aTile := AtomicBombTile new.
    aGame := SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 3 andTiles: aTile andShips: 1 andDice: {aLoadedDie}.
    aGame play.
    self assert: (aGame shipLap: 1) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test40WhenShip1IsAheadInLapsThenItIsFirstInRanking [
    | aGame aLoadedDie aTile |
    aLoadedDie := LoadedDie thatRolls: {5. 1.}.
    aTile := BasicTile new.
    aGame := SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 2 andTiles: aTile andShips: 2 andDice: {aLoadedDie}.
    aGame play. "nave 1 completa vuelta, lap=2"
    aGame play. "nave 2 avanza 1"
    self assert: aGame ranking equals: {1. 2}.
]

{ #category : 'tests' }
SpaceRaceTests >> test41WhenShipOnLap2LandsOnWormHoleThenItCanGoToPreviousLap [
    | aGame aLoadedDie aTile |
    aLoadedDie := LoadedDie thatRolls: {5.}.
    aTile := WormHoleTile new.
    aGame := SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 3 andTiles: aTile andShips: 1 andDice: {aLoadedDie}.
    aGame play. "lap 2 pos 1 - 4"
    self assert: (aGame shipPosition: 1) equals: 2.
    self assert: (aGame shipLap: 1) equals: 1.
]

{ #category : 'tests' }
SpaceRaceTests >> test42WhenShipLandsOnMoonWalkThenOtherShipsCanGoToPreviousLap [
    | aGame aLoadedDie aTile |
    aLoadedDie := LoadedDie thatRolls: {5.}.
    aTile := MoonWalkTile withAmountBack: 4.
    aGame := SpaceRace withTotalParsecs: 100 dividedInSpaces: 5 andLaps: 3 andTiles: aTile andShips: 2 andDice: {aLoadedDie}.
    aGame play. "nave 1 completa vuelta, lap=2 pos=1"
    aGame play. "nave 2 avanza 5 (lap=2 pos=1), cae en moonwalk -4 → nave 1 va a pos=1 lap=2"
    self assert: (aGame shipPosition: 1) equals: 2.
    self assert: (aGame shipLap: 1) equals: 1.
]

{ #category : 'tests' }
SpaceRaceTests >> test43WhenUsingBoardConstructorBasicTileAppearsBetween35And45Percent [

	| constructor tiles cantidadBasic ratio |
	constructor := BoardConstructor withMoonWalkAmountBack: 4 andParsecFactor: 100/8.
	tiles := (1 to: 10000) collect: [:_ | constructor tile].
	cantidadBasic := (tiles select: [:t | t isKindOf: BasicTile]) size.
	ratio := cantidadBasic / 10000.
	self assert: (ratio between: 0.35 and: 0.45).
]

{ #category : 'tests' }
SpaceRaceTests >> test44WhenUsingBoardConstructorSpeedUpTileAppearsBetween15And25Percent [

	| constructor tiles cantidadSpeedUp ratio cantidadBasic |
	constructor := BoardConstructor withMoonWalkAmountBack: 4 andParsecFactor: 100/8.
	tiles := (1 to: 10000) collect: [:_ | constructor tile].
	cantidadBasic := (tiles select: [:t | t isKindOf: BasicTile]) size.
	cantidadSpeedUp := (tiles select: [:t | t isKindOf: SpeedUpTile ]) size.
	ratio:= cantidadBasic /10000.
	self assert: (ratio between: 0.35 and: 0.45).
	ratio := cantidadSpeedUp / 10000.
	self assert: (ratio between: 0.15 and: 0.25).
]

{ #category : 'tests' }
SpaceRaceTests >> test45WhenUsingBoardConstructorTilesAppearBetweenExpectedValues [
    | constructor tiles counts total |
	constructor := BoardConstructor withMoonWalkAmountBack: 4 andParsecFactor: 100/8.
    tiles := (1 to: 10000) collect: [:_ | constructor tile].
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
        { BasicTile.      0.35. 0.45 }.
        { WormHoleTile.   0.15. 0.25 }.
        { SpeedUpTile.    0.15. 0.25 }.
        { MoonWalkTile.   0.07. 0.13 }.
        { HyperJumpTile.  0.05. 0.11 }.
        { AtomicBombTile. 0.00. 0.05 }.
    } do: [:entry |
        | tileClass min max ratio |
        tileClass := entry at: 1.
        min       := entry at: 2.
        max       := entry at: 3.
        ratio     := (counts at: tileClass) / total.
        self assert: (ratio between: min and: max)
		]
]
