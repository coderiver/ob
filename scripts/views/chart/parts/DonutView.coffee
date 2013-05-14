define (require) ->
	View = require 'View'
	Highcharts = require 'Highcharts'
	TotalView = require './../TotalView'


	class DonutView extends View

		listen:
			'@collection reset': 'render'
			'@collection change:color': 'renderChart'

		render: ->
			@chart = new Highcharts.Chart @getChartOptions()
			@renderChart()
			@renderText()


		renderChart: ->
			@chart.series[0].setData([])
			for row in @collection.getOrdinaryRows()
				@addChank row

			@redraw()


		renderText: ->
			@_getTotalView().render()


		_getTotalView: ->
			if @_totalView
				return @_totalView

			@_totalView = new TotalView(collection: @collection.checkedCollection)

			that = this
			@_totalView.render = ->
				that.setText @serialize()

			@_totalView.stopListening()
			@_totalView.delegateListeners()

			@_totalView


		setText: (text) ->
			@chart.setTitle text: text


		redraw: ->
			@chart.redraw()


		addChank: (model, redraw = false) ->
			series = @chart.series[0]
			series.addPoint
				name: model.get('name')
				y: model.get('total')
				color: model.get('color')
			, redraw


		getChartOptions: ->
			chart:
				renderTo: @el
				type: 'pie'
				animation: false

			title:
				text: null
				verticalAlign: 'middle'
				floating: true


			credits:
				enabled: false

			legend:
				enabled: false

			plotOptions:
				series:
					animation: false

				pie:
					innerSize: '50%'

			series: [{
				data: []
				dataLabels:
					formatter: ->
						"#{ @point.name } <br> #{ Math.round @point.percentage }%"
			}]
