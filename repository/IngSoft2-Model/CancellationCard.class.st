Class {
	#name : 'CancellationCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CancellationCard >> effectTo: arg1 among: arg2 andCancel: arg3 [

	(arg2 anySatisfy: [ :arg4 | arg4 checkCard: arg3 ]) ifFalse: [
		Error signal: 'Card isnt affecting this ship' ].
	arg2 do: [ :arg5 | arg5 cancel: arg3 ]
]

{ #category : 'accessing' }
CancellationCard >> name [
	^ 'cancellation'.
]
