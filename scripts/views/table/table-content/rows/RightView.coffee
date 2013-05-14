define (require) ->
	View = require 'View'
	template = require 'tpl!templates/table/rows/right.html'
	utils = require 'utils'


	class RightView extends View

		template: template

		tagName: 'tr'

		initialize: ->
			@listenTo @model, 'change:hide', @renderHide


		serialize: ->
			numFormat = @model.get 'numFormat'

			formatNumber: (number) ->
				utils.accounting.formatNumber number, numFormat.precision, numFormat.thousand, numFormat.decimal

			total: @model.get 'total'
			average: @model.get 'average'


		_render: ->
			@renderHide()


		renderHide: ->
			@$el.toggle !@model.get('hide')
