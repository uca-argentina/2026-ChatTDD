Class {
	#name : 'HardcodedShip',
	#superclass : 'Ship',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'initialization' }
HardcodedShip >> initializeWithName: shipName [

	| cardGen |
	name := shipName.
	absPosition := 1.
	lapPosition := 1.
	currentLap := 1.
	cardGen := CardGenerator new.
	hand := {
		        RepeatCard usingCounter: Counter start.
		        OverloadCard usingCounter: Counter start } asOrderedCollection.
	cardHistory := OrderedCollection new
]
