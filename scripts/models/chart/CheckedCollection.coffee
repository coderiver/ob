define (require) ->
	_ = require '_'
	Collection = require 'Collection'
	SeriesModel = require './SeriesModel'


	class CheckedCollection extends Collection

		model: SeriesModel

		listen:
			'@ reset': 'onReset'
			'@ add': 'onAdd'
			'@ remove': 'onRemove'


		initialize: ->
			@resetColors()


		onReset: ->
			@resetColors()
			@each @onAdd, this


		resetColors: ->
			@colors = [
				{ mainColor: '#9fc313', borderColor: '#9fc313', used: 0 }
				{ mainColor: '#60baea', borderColor: '#60baea', used: 0 }
				{ mainColor: '#f3b140', borderColor: '#f3b140', used: 0 }
				{ mainColor: '#ed745a', borderColor: '#ed745a', used: 0 }
				{ mainColor: '#46bfd9', borderColor: '#46bfd9', used: 0 }
				{ mainColor: '#d8aaeb', borderColor: '#d8aaeb', used: 0 }
				{ mainColor: '#8cb206', borderColor: '#8cb206', used: 0 }
				{ mainColor: '#92a7b3', borderColor: '#92a7b3', used: 0 }
			]


		onAdd: (seriesModel) ->
			color = _.min @colors, (color) -> color.used

			color.used += 1
			seriesModel.set
				color: color.mainColor
				borderColor: color.borderColor


		onRemove: (seriesModel) ->
			seriesColor = seriesModel.get 'color'
			seriesModel.setDefaultColor()

			color = _.find @colors, (color) ->
				color.mainColor == seriesColor

			color.used -= 1


		getTotal: ->
			@reduce (memo, rowModel) ->
				memo += rowModel.get 'total'
			, 0


		comparator: (model) ->
			-model.get 'total'
