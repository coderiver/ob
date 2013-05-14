define (require) ->
	View = require 'View'
	Highcharts = require 'Highcharts'


	class ColumnsView extends View

		firstCount: 3

		listen:
			'@collection reset add remove': 'render'

		render: ->
			@chart = new Highcharts.Chart @getChartOptions()
			# todo иницаиализация
			@renderChart()


		renderChart: ->
			@chart.series[0].setData([])

			@renderFirst @collection.models.slice 0, @firstCount
			@renderSecond @collection.models.slice @firstCount

			@chart.redraw()


		renderFirst: (columns) ->
			for column in columns
				@addColumn column


		renderSecond: (columns) ->
			unless columns.length
				return

			value = 0
			for column in columns
				value += column.get 'total'

			name = "Другие (#{columns.length})"
			color = '#aaa'

			@_addColumn name, value, color


		addColumn: (model) ->
			@_addColumn model.get('name'), model.get('total'), model.get('color')


		_addColumn: (name, value, color) ->
			@addCategory name
			@addPoint value, color


		addPoint: (value, color, redraw = false) ->
			series = @chart.series[0]

			series.addPoint
				y: value
				color: color
			, redraw


		addCategory: (name, redraw = false) ->
			categories = @chart.xAxis[0].categories
			categories.push name
			@chart.xAxis[0].setCategories categories, redraw


		getChartOptions: ->
			chart:
				renderTo: @el
				type: 'column'
				animation: false
				marginTop: 70

			title:
				text: null

			credits:
				enabled: false

			legend:
				enabled: false

			yAxis:
				title:
					text: null

				gridLineWidth: 2
				gridLineDashStyle: 'ShortDot'
				minorTickInterval: 'auto'
				endOnTick: false
				min: 0

			xAxis:
				gridLineWidth: 2
				minorTickInterval: 'auto'
				gridLineDashStyle: 'ShortDot'
				categories: []
				lineColor: 'transparent'
				tickLength: 0

			plotOptions:
				series:
					colorByPoint: true
					animation: false

			series: [{
				data: []
				color: ''
				dataLabels:
					enabled: true,
					color: '#000',
					align: 'center',
					style:
						fontSize: '13px',
						fontFamily: 'Verdana, sans-serif'
			}]