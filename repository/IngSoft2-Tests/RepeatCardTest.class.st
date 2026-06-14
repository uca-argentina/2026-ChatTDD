Class {
	#name : 'RepeatCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RepeatCardTest >> test01WhenNobodyRollDiceThenRepeatCardDoesntApplyEffect [

	| aGame tmp2 tmp3 tmp4 |
	tmp2 := LoadedDie thatRolls: { 3 }.
	tmp3 := BasicTile new.
	tmp4 := HardcodedBoardGenerator withTileType: tmp3.
	aGame := SpaceRaceHardcodedShips 
		        withTotalParsecs: 100
		        dividedInSpaces: 5
		        andLaps: 1
		        andBoardGenerator: tmp4
		        andShips: { 'tie fighter'. 'x wing' }
		        andDice: { tmp2 }.
	aGame useCard: 'repeat1' fromShip: 'tie fighter' toShip: 'tie fighter'.
	self assert: (aGame shipPosition: 'tie fighter') equals: 1.
	self assert: (aGame shipPosition: 'x wing') equals: 1.
	
	
]

{ #category : 'tests' }
RepeatCardTest >> test02WhenLastTileUsedIsABasicTileThenRepeatCardDoesntApplyEffect [

	| aGame tmp2 tmp3 tmp4 |
	tmp2 := LoadedDie thatRolls: { 3 }.
	tmp3 := BasicTile new.
	tmp4 := HardcodedBoardGenerator withTileType: tmp3.
	aGame := SpaceRaceHardcodedShips 
		        withTotalParsecs: 100
		        dividedInSpaces: 5
		        andLaps: 1
		        andBoardGenerator: tmp4
		        andShips: { 'tie fighter'. 'x wing' }
		        andDice: { tmp2 }.
	aGame play.
	aGame play.
	aGame useCard: 'repeat1' fromShip: 'tie fighter'.
	self assert: (aGame shipPosition: 'tie fighter') equals: 4.
	self assert: (aGame shipPosition: 'x wing') equals: 4.
]

{ #category : 'tests' }
RepeatCardTest >> test03WhenLastTileUsedIsAWormHoleTileThenRepeatCardApplyEffectToASelectedShip [

	| aGame tmp2 tmp3 tmp4 |
	tmp2 := LoadedDie thatRolls: { 10 }.
	tmp3 := WormHoleTile new.
	tmp4 := HardcodedBoardGenerator withTileType: tmp3.
	aGame := SpaceRaceHardcodedShips 
		        withTotalParsecs: 100
		        dividedInSpaces: 12
		        andLaps: 1
		        andBoardGenerator: tmp4
		        andShips: { 'tie fighter'. 'x wing' }
		        andDice: { tmp2 }.
	aGame play;
	play.
	aGame useCard: 'repeat1' fromShip: 'tie fighter' toShip: 'x wing'.
	self assert: (aGame shipPosition: 'tie fighter') equals: 7.
	self assert: (aGame shipPosition: 'x wing') equals: 3.
]

{ #category : 'tests' }
RepeatCardTest >> test04WhenLastTileUsedIsASpeedUpTileThenRepeatCardApplyEffectToASelectedShip [

	| aGame tmp2 tmp3 tmp4 |
	tmp2 := LoadedDie thatRolls: { 3 }.
	tmp3 := SpeedUpTile new.
	tmp4 := HardcodedBoardGenerator withTileType: tmp3.
	aGame := SpaceRaceHardcodedShips 
		        withTotalParsecs: 100
		        dividedInSpaces: 13
		        andLaps: 1
		        andBoardGenerator: tmp4
		        andShips: { 'tie fighter'. 'x wing' }
		        andDice: { tmp2 }.
	aGame play;
	play.
	aGame useCard: 'repeat1' fromShip: 'tie fighter' toShip: 'tie fighter'.
	self assert: (aGame shipPosition: 'tie fighter') equals: 12.
	self assert: (aGame shipPosition: 'x wing') equals: 8.
]

{ #category : 'tests' }
RepeatCardTest >> test05WhenLastTileUsedIsASMoonWalkTileThenRepeatCardApplyEffectToASelectedShip [

	| aGame tmp2 tmp3 tmp4 |
	tmp2 := LoadedDie thatRolls: { 3 }.
	tmp3 := MoonWalkTile withAmountBack: 1.
	tmp4 := HardcodedBoardGenerator withTileType: tmp3.
	aGame := SpaceRaceHardcodedShips 
		        withTotalParsecs: 100
		        dividedInSpaces: 10
		        andLaps: 1
		        andBoardGenerator: tmp4
		        andShips: { 'tie fighter'. 'x wing' }
		        andDice: { tmp2 }.
	aGame play;
	play.
	aGame useCard: 'repeat1' fromShip: 'tie fighter' toShip: 'x wing'.
	self assert: (aGame shipPosition: 'tie fighter') equals: 3.
	self assert: (aGame shipPosition: 'x wing') equals: 3.
]

{ #category : 'tests' }
RepeatCardTest >> test06WhenLastTileUsedIsAHyperJumpTileThenRepeatCardApplyEffectToASelectedShip [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 1 }.
	aTile := HyperJumpTile withParsecFactor: 100/16.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	aGame := SpaceRaceHardcodedShips 
		        withTotalParsecs: 100 dividedInSpaces: 30 andLaps: 1 andBoardGenerator: aBoardGenerator andShips:{ 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	aGame play. "1+ (80//6.25) = 13"
	aGame play. "1+ (50//6.25) = 9"
	aGame play. "13 + 1 + (20//6.25) = 17"
	aGame play. "9 + 1 + (80//6.25) = 22"
	aGame useCard: 'repeat1' fromShip: 'millenium falcon' toShip: 'millenium falcon'.
	self assert: (aGame shipPosition: 'millenium falcon') equals: 26. 
	self assert: (aGame shipPosition: 'tie fighter' ) equals: 23.
]

{ #category : 'tests' }
RepeatCardTest >> test07WhenLastTileUsedIsAtomicBombThenRepeatCardApplyEffectToASelectedShip [

	| aGame aLoadedDie aTile aBoardGenerator |
	aLoadedDie := LoadedDie thatRolls: { 10 . 8 }.
	aTile := AtomicBombTile new.
	aBoardGenerator := HardcodedBoardGenerator withTileType: aTile.
	aGame := SpaceRaceHardcodedShips 
		        withTotalParsecs: 100 dividedInSpaces: 10 andLaps: 2 andBoardGenerator: aBoardGenerator andShips:{ 'millenium falcon'. 'tie fighter' } andDice: {aLoadedDie }.
	aGame play;
	play.
	aGame useCard: 'repeat1' fromShip: 'millenium falcon' toShip: 'tie fighter'.
	self assert: (aGame shipLap: 'tie fighter' ) equals: 1.
]
