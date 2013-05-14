define (require) ->
	View = require 'View'
	ColumnsView = require './ColumnsView'
	DonutView = require './DonutView'
	MarkersView = require './../MarkersView'
	TotalView = require './../TotalView'

	template = require 'tpl!templates/chart/parts-chart.html'


	class PartsView extends View

		template: template

		_render: ->
			@add '@columns', ColumnsView, collection: @collection.checkedCollection
			@add '@donut', DonutView, collection: @collection
			@add '@markers', MarkersView, collection: @collection.checkedCollection
			@add '@total', TotalView, collection: @collection.checkedCollection
