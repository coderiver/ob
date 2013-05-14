define (require) ->
	View = require 'View'
	template = require 'tpl!templates/table/rows/center.html'
	utils = require 'utils'


	class CenterView extends View

		template: template

		tagName: 'tr'

		initialize: ->
			@paginationModel = @model.collection.paginationModel

			@listenTo @paginationModel, 'change:offset change:count', @render
			@listenTo @model, 'change:hide', @renderHide


		serialize: ->
			data = @model.get 'data'
			numFormat = @model.get 'numFormat'

			formatNumber: (number) ->
				utils.accounting.formatNumber number, numFormat.precision, numFormat.thousand, numFormat.decimal

			data: @paginationModel._sliceData(data)
			maxIndex: @maxIndex(data) - @paginationModel.get('offset')


		maxIndex: (arr) ->
			arr.indexOf Math.max(arr...)


		_render: ->
			@renderHide()


		renderHide: ->
			@$el.toggle !@model.get('hide')
