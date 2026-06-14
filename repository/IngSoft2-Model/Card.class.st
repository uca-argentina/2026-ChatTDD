Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Card >> effectTo: ship among: ships [
	^ self subclassResponsibility.
	
]

{ #category : 'accessing' }
Card >> target: targetingCard [
 
]

{ #category : 'as yet unclassified' }
Card >> target: targetCard cancelling: aCard [
]
