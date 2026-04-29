Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'position',
		'totalSpaces'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Game class >> default [
	^(self new)initializeSpaces: 5.
]

{ #category : 'as yet unclassified' }
Game class >> withSpaces: amountOfSpaces [
	amountOfSpaces<1 ifTrue:[
		Error signal: 'Board spaces cannot be less than 1'].
	^(self new)initializeSpaces: amountOfSpaces.
]

{ #category : 'testing' }
Game >> hasEnded [
	^(position>=totalSpaces).
]

{ #category : 'as yet unclassified' }
Game >> initializeSpaces: anInteger [
	position:= 0.
	totalSpaces:= anInteger 
]

{ #category : 'as yet unclassified' }
Game >> moveShip [
	position:=5.
]
