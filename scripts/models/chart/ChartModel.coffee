define (require) ->
	Model = require 'Model'


	class ChartModel extends Model

		defaults:
			chartType: 'linear'
			show: true

		listen:
			'sub category': 'onCategoryChange'
			'sub chart:toggle': 'toggle'

		onCategoryChange: (contextModel) ->
			type = if contextModel.isDateTime() then 'linear' else 'parts'
			@set chartType: type


		isLinear: ->
			@get('chartType') == 'linear'


		toggle: ->
			@toggleAttr 'show'

