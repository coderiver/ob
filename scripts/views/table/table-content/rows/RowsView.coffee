define (require) ->
	require 'baron'
	$ = require '$'
	View = require 'View'
	LeftView = require './LeftView'
	CenterView = require './CenterView'
	RightView = require './RightView'


	class RowsView extends View

		initialize: ->
			@listenTo @collection, 'reset sort', @renderRows
			@listenTo @collection, 'reset change:hide', @updateScroll


		render: ->
			@renderRows()
			@initScroll()


		renderRows: ->
			@clear()

			for rowModel in @collection.getOrdinaryRows()
				@addRow rowModel

			if averageRow = @collection.getAverageRow()
				@addRow averageRow

			if totalRow = @collection.getTotalRow()
				@addRow totalRow


		addRow: (rowModel) ->
			@_addRow '@table-left', rowModel, LeftView
			@_addRow '@table-center', rowModel, CenterView
			@_addRow '@table-right', rowModel, RightView


		_addRow: (selector, rowModel, RowView) ->
			view = new RowView
				model: rowModel

			@append selector, view


		clear: ->
			@$('@table-left').empty()
			@$('@table-center').empty()
			@$('@table-right').empty()


		initScroll: ->
			# todo dispose
			# todo selectors
			$('.supertable__wrapper').baron
				scroller: '.supertable__scroller'
				container: '.supertable__content'
				bar: '.scroller__bar'
				barOnCls: 'supertable__baron'


		updateScroll: ->
			baron.u()
