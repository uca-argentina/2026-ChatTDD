Class {
	#name : 'Tests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
Tests >> test01WhenTheGameIsNotOverThenTheGameHasNotEnded [
		|aGame|
	aGame:= Game default.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
Tests >> test02WhenShipPassesFinishLineTheGameHasEnded [
		|aGame |
	aGame:= Game default.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
Tests >> test03WhenTheShipMovesButDoesntCrossFinishLineThenTheGameDoesNotEnd [
		|aGame|
	aGame:= Game withSpaces: 7.
	aGame play.
	self deny: (aGame hasEnded).
]

{ #category : 'tests' }
Tests >> test04WhenBoardLengthIsZeroThenGameNotCreated [
		|aGame|
		self
			should:[Game withSpaces: 0]
			raise: Error
			withExceptionDo:[ :error |
				self
					assert: error messageText
					equals: 'Board spaces cannot be less than 1']

]

{ #category : 'tests' }
Tests >> test05WhenBoardLengthIsNegativeThenGameNotCreated [
		|aGame|
		self
			should:[Game withSpaces: -3]
			raise: Error
			withExceptionDo:[ :error |
				self
					assert: error messageText
					equals: 'Board spaces cannot be less than 1']

]

{ #category : 'tests' }
Tests >> test06WhenAGameIsCreateWith2ShipsThenTheGameHas2Ships [
		|aGame|
	aGame:= Game withSpaces: 7.
	self assert: ((aGame amountOfShips)= 2).
]

{ #category : 'tests' }
Tests >> test07WhenTwoShipsAreMovedThenBothShipsChangePosition [
		|aGame|
	aGame:= Game withSpaces: 7.
	aGame play.
	aGame play.
	self assert: ((aGame shipPosition: 2)= 5).
]

{ #category : 'tests' }
Tests >> test08WhenThereAre2ShipsAndOneMoves3AndOtherMoves5ThenOneIsOn3AndTheOtherOneOn5 [

	|aGame aFixedDie|
	aFixedDie := FixedDie thatRolls: {5. 3}.
	aGame:= Game withSpaces: 7 andDice: {aFixedDie}.
	aGame play.
	aGame play.
	self assert: (((aGame shipPosition: 2)= 3) and: ((aGame shipPosition: 1)= 5)).
]

{ #category : 'tests' }
Tests >> test09WhenFirstShipWinsThenTheGameEnds [

		|aGame aFixedDie |
	aFixedDie := FixedDie thatRolls: {2. 5. 5.}.
	aGame:= Game withSpaces: 7 andDice: {aFixedDie}.
	aGame play.
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
Tests >> test10WhenSecondShipWinsThenTheGameEnds [

		|aGame aFixedDie |
	aFixedDie := FixedDie thatRolls: {5. 7.}.
	aGame:= Game withSpaces: 7 andDice: {aFixedDie}.
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
Tests >> test11WhenTheGameIsCreatedWith4ShipsThen4ShipsExist [

		|aGame|
	aGame:= Game withSpaces: 7 andShips: 4.
	self assert: (aGame amountOfShips = 4).
]

{ #category : 'tests' }
Tests >> test12WhenTheOnlyPlayerWinsThenThePlayerIsTheWinner [
		|aGame |
	aGame:= Game default.
	aGame play.
	self assert: (aGame declareWinner = 1).
]

{ #category : 'tests' }
Tests >> test13WhenTheGameIsntFinishedThenThereIsNoWinner [
		|aGame |
	aGame:= Game default.
	aGame moveShip:1.
	self assert: (aGame declareWinner = 'No winner').
]

{ #category : 'tests' }
Tests >> test14WhenSecondPlayerWinsThenIsDeclaredWinner [
		
	|aGame aFixedDie |
	aFixedDie := FixedDie thatRolls: {1. 7.}.
	aGame:= Game withSpaces: 7 andShips:2 andDice: {aFixedDie}.
	aGame play.
	aGame play.
	self assert: (aGame declareWinner = 2).
]

{ #category : 'tests' }
Tests >> test15WhenSomeoneWonThenNoShipCanKeepPlaying [
		|aGame |
		
		self
			should:[
				aGame:= Game withSpaces: 5 andShips: 2.
				aGame play.
				aGame play.
				]
			raise: Error
			withExceptionDo:[ :error |
				self
					assert: error messageText
					equals: 'Game is over. Ships cannot move anymore.']	
]

{ #category : 'tests' }
Tests >> test16WhenTheGameEndedThenFinalPositionOfShipIs5 [
	|aGame aFixedDie |
	aFixedDie := FixedDie thatRolls: {5.}.
	aGame:= Game defaultWithDice: {aFixedDie}.
	aGame play.
	self assert: (aGame finalPositions = {5} asOrderedCollection ).
]

{ #category : 'tests' }
Tests >> test17WhenAGameIsNotOverThenFinalPositionsAreNotDefined [
	|aGame aFixedDie |

	self
			should:[
				aFixedDie := FixedDie thatRolls: {3.}.
				aGame:= Game defaultWithDice: {aFixedDie}.
				aGame play.
				aGame finalPositions .
				]
			raise: Error
			withExceptionDo:[ :error |
				self
					assert: error messageText
					equals: 'Game is not over. Final positions are not defined yet.']	
]

{ #category : 'tests' }
Tests >> test18WhenAShipCrossedTheFinishLineThenItsFinalPositionIsTheLastSpace [
	| aFixedDie aGame |
	aFixedDie := FixedDie thatRolls: {8.}.
	aGame:= Game defaultWithDice: {aFixedDie}.
	
	aGame play.
	self assert: (aGame finalPositions = {8} asOrderedCollection ).
]

{ #category : 'tests' }
Tests >> test19WhenGameWithMultiplePlayersEndsThenReturnsEachPlayerFinalPosition [
	|aGame aFixedDie |
	aFixedDie := FixedDie thatRolls: {4. 5.}.
	aGame:= Game withSpaces: 5 andShips:2 andDice: {aFixedDie}.
	aGame play.
	aGame play.
	self assert: (aGame finalPositions = {4. 5} asOrderedCollection ).
]

{ #category : 'tests' }
Tests >> test20WhenAGameHasMultipleDiceThenTheShipMovesTheSumOfTheDice [
	|aGame aFixedDie anotherFixedDie|
	
    aFixedDie := FixedDie thatRolls: {2. 5. 5.}.
    anotherFixedDie := FixedDie thatRolls: {2. 5. 5.}.

    aGame:= Game withSpaces: 7 andDice: {aFixedDie. anotherFixedDie. }.
    aGame play.
    self assert: ((aGame shipPosition:1 )= 4).
]

{ #category : 'tests' }
Tests >> test21WhenGameHasOneDieWith6SidesThenTheShipMovesBetween1and6 [

|aGame aDie |
	
    aDie := Die default.

    aGame:= Game withSpaces: 7 andDice: {aDie. }.
    aGame play.
    self assert: (((aGame shipPosition:1 )>=1) and: ((aGame shipPosition:1 )<=6)).
]

{ #category : 'tests' }
Tests >> test22WhenGameHasOneDieWith10SidesThenTheShipMovesBetween1and3 [

|aGame aDie |
	
    aDie := Die withSides: 3.

    aGame:= Game withSpaces: 3 andDice: {aDie. }.
    aGame play.

    self assert: (((aGame shipPosition:1 )>=1) and: ((aGame shipPosition:1 )<=3)).
]

{ #category : 'tests' }
Tests >> test23WhenGameHas2DieWith10And6SidesSidesThenTheShipMovesBetween1and16 [

|aGame aDie anotherDie |
	
    aDie := Die withSides: 10.
	 anotherDie := Die default.
    aGame:= Game withSpaces: 10 andDice: {aDie. anotherDie. }.
    aGame play.
    self assert: (((aGame shipPosition:1 )>=1) and: ((aGame shipPosition:1 )<=16)).
]

{ #category : 'tests' }
Tests >> test24WhenMessagePlayUntilEndsIsCalledThenTheGameCanAutomaticallyEndWhenSomeOneWIns [

|aGame aDie anotherDie |
	
    aDie := Die withSides: 10.
	 anotherDie := Die default.
    aGame:= Game withSpaces: 100 andShips: 4 andDice: {aDie. anotherDie. }.
    aGame playUntilEnds.
    self assert: (aGame hasEnded ).
]

{ #category : 'tests' }
Tests >> testDummy [

	self assert: Dummy new isDummy
]
