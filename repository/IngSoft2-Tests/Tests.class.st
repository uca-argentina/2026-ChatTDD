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
	aGame moveShip.
	self assert: (aGame hasEnded).
]

{ #category : 'tests' }
Tests >> test03WhenTheShipMovesButDoesntCrossFinishLineThenTheGameDoesNotEnd [
		|aGame|
	aGame:= Game withSpaces: 7.
	aGame moveShip.
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
	aGame moveShip.
	aGame moveShip.
	self assert: ((aGame shipPosition: 2)= 5).
]

{ #category : 'tests' }
Tests >> testDummy [

	self assert: Dummy new isDummy
]
