Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'executing' }
Card >> effectTo: ship among: ships [
	^ self subclassResponsibility.
	
]

{ #category : 'accessing' }
Card >> target: targetingCard [
 
]

{ #category : 'executing' }
Card >> target: targetCard cancelling: aCard [
]
