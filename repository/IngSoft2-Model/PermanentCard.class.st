Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
PermanentCard >> isPlayable: canPlayerUseCard [

	^ canPlayerUseCard ifFalse: [
		Error signal: 'Ship cant use permanent card outside its turn' ].
]
