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
	aGame:= Game withSpaces: 7 andDice: aFixedDie.
	aGame play.
	aGame play.
	self assert: (((aGame shipPosition: 2)= 3) and: ((aGame shipPosition: 1)= 5)).
]

{ #category : 'tests' }
Tests >> test09WhenFirstShipWinsThenTheGameEnds [

		|aGame aFixedDie |
	aFixedDie := FixedDie thatRolls: {2. 5. 5.}.
	aGame:= Game withSpaces: 7 andDice: aFixedDie.
	aGame play.
	aGame play.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
Tests >> test10WhenSecondShipWinsThenTheGameEnds [

		|aGame aFixedDie |
	aFixedDie := FixedDie thatRolls: {5. 7.}.
	aGame:= Game withSpaces: 7 andDice: aFixedDie.
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
	aGame:= Game withSpaces: 7 andShips:2 andDice: aFixedDie.
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
Tests >> test16WhenTheGameEndedThenFinalPositionOfShip1Is7 [
	|aGame aFixedDie |
	aFixedDie := FixedDie thatRolls: {7.}.
	aGame:= Game defaultWithDice: aFixedDie.
	aGame play.
	self assert: (aGame finalPositionOfCurrentPlayer = {'Player 1'. 'Position 5'}).
]

{ #category : 'tests' }
Tests >> test17WhenAGameIsNotOverThenFinalPositionsAreNotDefine [
	|aGame aFixedDie |

	self
			should:[
				aFixedDie := FixedDie thatRolls: {3.}.
				aGame:= Game defaultWithDice: aFixedDie.
				aGame play.
				aGame finalPositionOfCurrentPlayer.
				]
			raise: Error
			withExceptionDo:[ :error |
				self
					assert: error messageText
					equals: 'Game is not over. Final positions are not define yet.']	
]

{ #category : 'tests' }
Tests >> test18WhenAShipCrossedTheFinishLineThenItsFinalPositionIsTheLastSpace [
	| aFixedDie aGame |
	aFixedDie := FixedDie thatRolls: {8.}.
	aGame:= Game defaultWithDice: aFixedDie.
	
	aGame play.
	self assert: (aGame finalPositionOfCurrentPlayer = {'Player 1'. 'Position 5'}).
]

{ #category : 'tests' }
Tests >> test19WhenGameWithMultiplePlayersEndsThenReturnsEachPlayerFinalPosition [
	|aGame aFixedDie |
	aFixedDie := FixedDie thatRolls: {4. 5.}.
	aGame:= Game withSpaces: 5 andShips:2 andDice: aFixedDie.
	aGame play.
	aGame play.
	self assert: (aGame finalPositions = {{'Player 1'. 'Position 4'} . {'Player 2'. 'Position 5'}}).
]

{ #category : 'tests' }
Tests >> testDummy [

	self assert: Dummy new isDummy
]
