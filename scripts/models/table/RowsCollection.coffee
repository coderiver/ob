define (require) ->
	_ = require '_'
	Collection = require 'Collection'
	RowModel = require './RowModel'


	class RowsCollection extends Collection

		model: RowModel

		initialize: (models, options) ->
			@paginationModel = options.paginationModel
			@listenTo this, 'reset', @onReset


		onReset: ->
			@createAverageRow()
			@createTotalRow()
			@paginationModel.set rowLength: @getRowLength()


		getRowLength: ->
			@at(0)?.getLength()


		createAverageRow: ->
			@add
				id: -2
				name: 'Среднее'
				data: @getRowsAverage()


		createTotalRow: ->
			@add
				id: -1
				name: 'Итого'
				data: @getRowsTotal()


		getRowsTotal: ->
			rowsData = for rowModel in @getOrdinaryRows()
				rowModel.get('data')

			_.reduce rowsData, (memo, row) ->
				for cell, index in row
					(memo[index] or 0) + cell
			, []


		getRowsAverage: ->
			for cell in @getRowsTotal()
				Math.round cell / @length


		getOrdinaryRows: ->
			@filter (row) ->
				not row.id? or row.id > -1


		getTotalRow: ->
			@get -1


		getAverageRow: ->
			@get -2


		getCheckedRows: ->
			@filter (row) -> row.get 'checked'


		checkAll: (checked = true) ->
			@each (row) ->
				row.check checked, {dontpub: true}

			# Для мнгновенного обновление графиков
			setTimeout =>
				@publishEvent 'table:update'
			, 0


		isAllChecked: ->
			@getCheckedRows().length == @length


		uncheckRow: (id) ->
			@get(id).set checked: false
