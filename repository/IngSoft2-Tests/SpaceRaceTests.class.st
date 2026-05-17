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
	self assert: (aGame shipPosition: 2)equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test08WhenEachShipMovesThenItMovesItsOwnAmountOfSquares [

		|aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aTile:= BasicTile new.
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie }.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 5.
	self assert: (aGame shipPosition: 2) equals: 5.
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
   	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 6 andTiles: aTile andShips:1 andDice: {aLoadedDie }.
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
	self assert: aGame finalPositions equals: {5. 0} asOrderedCollection .
]

{ #category : 'tests' }
SpaceRaceTests >> test20WhenGameHasMultipleDiceThenTheShipsShouldMoveTheSumOfTheDice [

|aGame aLoadedDie anotherDie aTile |
	
    aLoadedDie := LoadedDie thatRolls: {2}.
	 anotherDie := LoadedDie thatRolls: {2}.
	aTile := BasicTile new.
    aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 10 andTiles: aTile andShips:1 andDice: {aLoadedDie. anotherDie. }.
    aGame play.
    self assert: (aGame shipPosition:1 ) equals: 4.
]

{ #category : 'tests' }
SpaceRaceTests >> test21WhenShipLandsOnSpeedUpTileThenItMovesForward4Tiles [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := SpeedUpTile new.
   aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 6 andTiles: aTile andShips:2 andDice: {aLoadedDie }.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 5. 
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
    self assert: (aGame shipPosition: 1) equals: 4.
    self assert: (aGame shipPosition: 2) equals: 4.
]

{ #category : 'tests' }
SpaceRaceTests >> test24WhenShipLandsOnSpeedUpAndMovesToAnotherSpeedUpTheEffectsDontStack [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := SpeedUpTile new.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 6. 
]

{ #category : 'tests' }
SpaceRaceTests >> test25WhenShipLandsOnWormHoleTileThenItMovesBack4Tiles [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {5}.
	aTile := WormHoleTile new.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 1. 
]

{ #category : 'tests' }
SpaceRaceTests >> test26WhenShipLandsOnWormHoleTileThenItCannotGoBehindPosition0 [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := WormHoleTile new.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 0. 
]

{ #category : 'tests' }
SpaceRaceTests >> test27WhenShipLandsOnMoonWalkTileThenShipIsntAffected [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := MoonWalkTile withAmountBack: 1.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 2. 
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
	self assert: (aGame shipPosition: 1) equals: 1. 
	self assert: (aGame shipPosition: 2) equals: 2. 
	self assert: (aGame shipPosition: 3) equals: 0. 
]

{ #category : 'tests' }
SpaceRaceTests >> test29WhenAShipLandsOnAtomicBombTIleThenAllShipsGoBackToTheStart [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {6}.
	aTile := AtomicBombTile new.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 7 andTiles: aTile andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 0. 
	
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
					equals: 'Total parsecs can not be equal or less than 0' ]
	
]

{ #category : 'tests' }
SpaceRaceTests >> test31WhenAShipLandsOnHyperJumpTileThenTheShipMovesInParsecs [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := HyperJumpTile withParsecFactor: 100/8.
	aGame:= SpaceRace withTotalParsecs: 100 dividedInSpaces: 8 andTiles: aTile andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 7. 
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
	self assert: (aGame shipPosition: 1) equals: 17. 
	self assert: (aGame shipPosition: 2) equals: 22. 
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
