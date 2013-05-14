define (require) ->
	_ = require '_'
	View = require 'View'
	Highcharts = require 'Highcharts'
	utils = require 'utils'


	# todo recato
	class LinearView extends View

		listen:
			'@collection reset': 'render'
			'@collection add': 'addSeries'
			'@collection remove': 'removeSeries'
			'@collection remove': 'setAllNormal'
			'@collection change:selected': 'onChangeSelect'


		render: ->
			@chart = new Highcharts.Chart @getChartOptions()

			@addSeriesList @collection.models, false
			@redraw()


		redraw: ->
			@chart.redraw()


		addSeriesList: (seriesList, redraw) ->
			for series in seriesList
				@addSeries series, redraw


		addSeries: (series, redraw) ->
			@chart.addSeries series.toJSON(), redraw


		removeSeries: (seriesModel) ->
			@getSeriesById(seriesModel.id).remove()


		getSeriesById: (id) ->
			_.find @chart.series, (series) ->
				series.options.id == id


		getChartOptions: ->
			chart:
				renderTo: @el
				type: 'line'
				marginRight: 130
				marginTop: 70
				animation: false

			title:
				text: null

			credits:
				enabled: false

			legend:
				enabled: false

			xAxis:
				type: 'category'
				tickmarkPlacement: 'on'
				categories: @collection?.columnsModel?.getChartCategories() or []
				gridLineWidth: 1
				gridLineDashStyle: 'ShortDot'
				lineColor: '#60baea'
				lineWidth: 3
				labels:
					y: 25
					style:
						color: '#282f34'
						fontWeight: 'bold'
						fontSize:'14px'

			yAxis:
				title:
					text: null

				labels:
					x: -100
					style:
						color: '#282f34'
						fontWeight: 'bold'
						fontSize:'14px'

				gridLineWidth: 2
				gridLineDashStyle: 'ShortDot'
				endOnTick: false
				min: 0

			plotOptions:
				line:
					marker:
						symbol: 'circle'

				series:
					animation: false

			series: [{}]


		onChangeSelect: (seriesModel) ->
			if seriesModel.get 'selected'
				@selectOne(seriesModel)
			else
				@setAllNormal()


		setAllNormal: ->
			@collection.each (seriesModel) =>
				@setSeriesVisibility seriesModel, 1

			@redraw()


		selectOne: (seriesModel)->
			@collection.each (seriesModel) =>
				@setSeriesVisibility seriesModel, 0.2

			@setSeriesVisibility seriesModel, 1
			@redraw()


		setSeriesVisibility: (seriesModel, visibility) ->
			originalColor = seriesModel.get 'color'
			rgb = utils.hexToRgb originalColor
			color = "rgba(#{rgb.r},#{rgb.g},#{rgb.b},#{visibility})"

			series = @getSeriesById(seriesModel.id)
			@setSeriesColor(series, color)


		setSeriesColor: (series, color) ->
			series.color = color
			series.graph.attr stroke: color

			for point in series.data
				point.graphic.attr fill: color

