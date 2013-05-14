define (require) ->
	View = require 'View'
	LinearView = require './LinearView'
	MarkersView = require './../MarkersView'
	TotalView = require './../TotalView'

	template = require 'tpl!templates/chart/series-chart.html'


	class SeriesView extends View

		template: template

		_render: ->
			@add '@chart', LinearView, collection: @collection.checkedCollection
			@add '@markers', MarkersView, collection: @collection.checkedCollection
			@add '@total', TotalView, collection: @collection.checkedCollection
