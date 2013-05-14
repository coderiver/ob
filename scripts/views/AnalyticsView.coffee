define (require) ->
	View = require 'View'

	StatsModel = require 'models/stats/StatsModel'
	MenuView = require 'views/menu/MenuView'

	ChartModel = require 'models/chart/ChartModel'
	ChartView = require 'views/chart/ChartView'

	TableModel = require 'models/table/TableModel'
	TableView = require 'views/table/TableView'


	class AnalyticsView extends View

		render: ->
			stats = new StatsModel()
			stats.fetch()

			@add '@menu', MenuView, model: stats
			@add '@chart', ChartView, model: new ChartModel()
			@add '@table', TableView, model: new TableModel()

