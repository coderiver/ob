define (require) ->
	View = require 'View'

	SeriesCollection = require 'models/chart/SeriesCollection'
	SeriesView = require './series/SeriesView'
	PartsView = require './parts/PartsView'


	class ChartView extends View

		listen:
			'@model change:chartType': 'renderChartType'
			'@model change:show': 'renderShow'

		initialize: ->
			@seriesCollection = new SeriesCollection()


		render: ->
			@renderShow()
			@renderChartType()


		renderShow: ->
			@$el.toggle @model.get('show')


		renderChartType: ->
			if @model.isLinear()
				@switchToLinear()
			else
				@switchToColumns()


		switchChart: (chartView) ->
			@chartView?.dispose()
			@chartView = chartView
			@append chartView

		# todo ???
		switchToLinear: ->
			@seriesCollection.reset()
			@switchChart new SeriesView(collection: @seriesCollection)


		switchToColumns: ->
			@seriesCollection.reset()
			@switchChart new PartsView(collection: @seriesCollection)

