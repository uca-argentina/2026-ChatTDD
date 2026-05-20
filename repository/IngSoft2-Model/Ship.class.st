Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'currentLap',
		'absPosition',
		'lapPosition',
		'name'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Ship class >> withName: name [
	^ (self new) initializeWithName: name.
]

{ #category : 'accessing' }
Ship >> currentLap [
	^ currentLap.
]

{ #category : 'initialization' }
Ship >> initializeWithName: shipName [
	
	name := shipName.
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

{ #category : 'accessing' }
Ship >> name [
^name.
]

{ #category : 'execution' }
Ship >> resetToStartOfLap [

	lapPosition := 1
]

{ #category : 'initialization' }
Ship >> setCurrentLap: maxPosition [
	currentLap := (absPosition - 1) // maxPosition + 1.

]

{ #category : 'initialization' }
Ship >> setLapPosition: maxPosition [
	lapPosition := (absPosition - 1) \\ maxPosition + 1.
]
