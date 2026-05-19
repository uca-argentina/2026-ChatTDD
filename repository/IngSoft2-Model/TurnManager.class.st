Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'currentTurn',
		'totalTurns'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
TurnManager class >> withTotalTurns: totalTurns [
	^(self new) initializeWithTotalTurns: totalTurns 
	
]

{ #category : 'as yet unclassified' }
TurnManager >> changeTurn [
	currentTurn:= currentTurn\\ totalTurns + 1.
]

{ #category : 'accessing' }
TurnManager >> currentTurn [
^currentTurn 
]

{ #category : 'initialization' }
TurnManager >> initializeWithTotalTurns: amountOfTurns [
	totalTurns:= amountOfTurns.
	currentTurn:= 1
]
