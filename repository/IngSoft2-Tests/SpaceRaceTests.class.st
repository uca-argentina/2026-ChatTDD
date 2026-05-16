Class {
	#name : 'SpaceRaceTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceRaceTests >> test01WhenTheGameIsNotOverThenTheGameHasNotEnded [
		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aGame:= SpaceRace withSpaces: 5 andShips:1 andDice: {aLoadedDie}.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test02WhenShipPassesFinishLineTheGameHasEnded [
		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aGame:= SpaceRace withSpaces: 5 andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test03WhenTheShipMovesButDoesntCrossFinishLineThenTheGameDoesNotEnd [
		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aGame:= SpaceRace withSpaces: 7 andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test04WhenBoardLengthIsZeroThenGameNotCreated [

	| aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: { 5 }.

	self
		should: [
		aGame := SpaceRace withSpaces: 0 andShips: 1 andDice: { aLoadedDie } ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Board spaces cannot be less than 1' ]
]

{ #category : 'tests' }
SpaceRaceTests >> test05WhenBoardLengthIsNegativeThenGameNotCreated [

	| aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: { 5 }.

	self
		should: [
		aGame := SpaceRace withSpaces: -3 andShips: 1 andDice: { aLoadedDie } ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Board spaces cannot be less than 1' ]

]

{ #category : 'tests' }
SpaceRaceTests >> test06WhenAGameIsCreateWith2ShipsThenTheGameHas2Ships [
		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aGame:= SpaceRace withSpaces: 7 andShips:2 andDice: {aLoadedDie}.
	self assert: (aGame amountOfShips) equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test07WhenTwoShipsAreMovedThenBothShipsChangePosition [
		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aGame:= SpaceRace withSpaces: 7 andShips:2 andDice: {aLoadedDie}.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 2)equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test08WhenEachShipMovesThenItMovesItsOwnAmountOfSquares [

		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aGame:= SpaceRace withSpaces: 7 andShips:2 andDice: {aLoadedDie}.
	aGame play.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 5.
	self assert: (aGame shipPosition: 2) equals: 5.
]

{ #category : 'tests' }
SpaceRaceTests >> test09WhenFirstShipWinsThenTheGameEnds [

		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5}.
	aGame:= SpaceRace withSpaces: 7 andShips:2 andDice: {aLoadedDie}.
	aGame play.
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test10WhenSecondShipWinsThenTheGameEnds [

		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5. 7.}.
	aGame:= SpaceRace withSpaces: 7 andShips:2 andDice: {aLoadedDie}.
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
SpaceRaceTests >> test11WhenTheGameIsCreatedWith4ShipsThen4ShipsExist [

		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aGame:= SpaceRace withSpaces: 7 andShips:4 andDice: {aLoadedDie}.
	self assert: aGame amountOfShips equals: 4.
]

{ #category : 'tests' }
SpaceRaceTests >> test12WhenTheOnlyPlayerWinsThenThePlayerIsTheWinner [
		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aGame:= SpaceRace withSpaces: 5 andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self assert: aGame winner equals: 1.
]

{ #category : 'tests' }
SpaceRaceTests >> test13WhenTheGameIsntFinishedThenThereIsNoWinner [
		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aGame:= SpaceRace withSpaces: 6 andShips:1 andDice: {aLoadedDie}.
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
		
	|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {1. 7.}.
	aGame:= SpaceRace withSpaces: 7 andShips:2 andDice: {aLoadedDie}.
	aGame play.
	aGame play.
	self assert: aGame winner equals: 2.
]

{ #category : 'tests' }
SpaceRaceTests >> test15WhenSomeoneWonThenNoShipCanKeepPlaying [
		|aGame |
		aGame := SpaceRace withSpaces: 5 andShips: 1 andDice: {(LoadedDie thatRolls: {6.})}.
		aGame play.  "la nave gana"
		self should: [ aGame play ] raise: Error
		withExceptionDo:[ :error |
			self
				assert: error messageText
				equals: 'Game is over. Ships cannot move anymore.']	
]

{ #category : 'tests' }
SpaceRaceTests >> test16WhenTheGameEndedThenFinalPositionOfShipIs5 [
		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5.}.
	aGame:= SpaceRace withSpaces: 5 andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self assert: aGame finalPositions equals: {5} asOrderedCollection.
]

{ #category : 'tests' }
SpaceRaceTests >> test17WhenAGameIsNotOverThenFinalPositionsAreNotDefined [
	|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {3.}.
	aGame:= SpaceRace withSpaces: 5 andShips:1 andDice: {aLoadedDie}.
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
		|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {8.}.
	aGame:= SpaceRace withSpaces: 5 andShips:1 andDice: {aLoadedDie}.
	
	aGame play.
	self assert: aGame finalPositions equals: {5} asOrderedCollection .
]

{ #category : 'tests' }
SpaceRaceTests >> test19WhenGameWithMultiplePlayersEndsThenReturnsEachPlayerFinalPosition [
	|aGame aLoadedDie |
	aLoadedDie := LoadedDie thatRolls: {5. 0.}.
	aGame:= SpaceRace withSpaces: 5 andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: aGame finalPositions equals: {5. 0} asOrderedCollection .
]

{ #category : 'tests' }
SpaceRaceTests >> test20WhenGameHasMultipleDiceThenTheShipsShouldMoveTheSumOfTheDice [

|aGame aLoadedDie anotherDie |
	
    aLoadedDie := LoadedDie thatRolls: {2}.
	 anotherDie := LoadedDie thatRolls: {2}.
    aGame:= SpaceRace withSpaces: 10 andShips:1 andDice: {aLoadedDie. anotherDie. }.
    aGame play.
    self assert: (aGame shipPosition:1 ) equals: 4.
]

{ #category : 'tests' }
SpaceRaceTests >> test21WhenShipLandsOnSpeedUpTileThenItMovesForward4Tiles [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := SpeedUpTile new.
	aGame:= SpaceRace withSpaces: 6 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 5. 
]

{ #category : 'tests' }
SpaceRaceTests >> test22WhenShipsEndsOnASpeedUpTileThenGameEndsAndSpeedUpIsntPlayed [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {5}.
	aTile := SpeedUpTile new.
	aGame:= SpaceRace withSpaces: 5 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
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
    | aGame aDie |
    aDie := LoadedDie thatRolls: {4. 4.}.
    aGame := SpaceRace withSpaces: 10 andShips: 2 andDice: {aDie}.
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
	aGame:= SpaceRace withSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 6. 
]

{ #category : 'tests' }
SpaceRaceTests >> test25WhenShipLandsOnWormHoleTileThenItMovesBack4Tiles [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {5}.
	aTile := WormHoleTile new.
	aGame:= SpaceRace withSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 1. 
]

{ #category : 'tests' }
SpaceRaceTests >> test26WhenShipLandsOnWormHoleTileThenItCannotGoBehindPosition0 [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := WormHoleTile new.
	aGame:= SpaceRace withSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 0. 
]

{ #category : 'tests' }
SpaceRaceTests >> test27WhenShipLandsOnMoonWalkTileThenShipIsntAffected [

	| aGame aLoadedDie aTile|
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := MoonWalkTile withAmountBack: 1.
	aGame:= SpaceRace withSpaces: 7 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 2. 
]

{ #category : 'tests' }
SpaceRaceTests >> test28WhenSecondShipLandsOnMoonWalkTideThenTheOtherShipsMoveBackNTiles [

	| aGame aLoadedDie aTile anAmountBack |
	anAmountBack := 1.
	aLoadedDie := LoadedDie thatRolls: {2}.
	aTile := MoonWalkTile withAmountBack: anAmountBack.
	aGame:= SpaceRace withSpaces: 7 andTiles: aTile andShips:3 andDice: {aLoadedDie}.
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
	aGame:= SpaceRace withSpaces: 7 andTiles: aTile andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 0. 
	
]

{ #category : 'tests' }
SpaceRaceTests >> test30WhenAShipLandsOnHyperJumpTileThenTheShipMovesInParsecs [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := HyperJumpTile default.
	aGame:= SpaceRace withSpaces: 8 andTiles: aTile andShips:1 andDice: {aLoadedDie}.
	aGame play.
	self assert: (aGame shipPosition: 1) equals: 7. 
]

{ #category : 'tests' }
SpaceRaceTests >> test31WhenMultipleShipsLandOnHyperJumpThenJumpDistanceRotates [

	| aGame aLoadedDie aTile |
	aLoadedDie := LoadedDie thatRolls: {1}.
	aTile := HyperJumpTile default.
	aGame:= SpaceRace withSpaces: 16 andTiles: aTile andShips:2 andDice: {aLoadedDie}.
	aGame play. "0 + 1 + 3*2 = 7"
	aGame play. "0 + 1 + 2*2 = 5"
	aGame play. "7 + 1 + 1*2 = 10"
	aGame play. "5 + 1 + 3*2 = 12"
	self assert: (aGame shipPosition: 1) equals: 10. 
	self assert: (aGame shipPosition: 2) equals: 12. 
]
