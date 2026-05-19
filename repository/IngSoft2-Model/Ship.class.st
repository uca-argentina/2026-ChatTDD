Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'currentLap',
		'absPosition',
		'lapPosition'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Ship class >> default [
	^ (self new) initializePosition.
]

{ #category : 'accessing' }
Ship >> currentLap [
	^ currentLap.
]

{ #category : 'initialization' }
Ship >> initializePosition [

	absPosition := 1.
	lapPosition := 1.
	currentLap := 1
]

{ #category : 'execution' }
Ship >> lapPosition [
	^ lapPosition .
]

{ #category : 'execution' }
Ship >> move: amountToMove limitedToSpaces: maxPosition andLaps: amountOfLaps [

   absPosition := (absPosition + amountToMove ) min: maxPosition * amountOfLaps max: 1.
	self setCurrentLap: maxPosition.
	self setLapPosition: maxPosition. 


]

{ #category : 'initialization' }
Ship >> setCurrentLap: maxPosition [
	currentLap := (absPosition - 1) // maxPosition + 1.

]

{ #category : 'initialization' }
Ship >> setLapPosition: maxPosition [
	lapPosition := (absPosition - 1) \\ maxPosition + 1.
]
