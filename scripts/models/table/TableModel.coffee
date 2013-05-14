define (require) ->
	Model = require 'Model'
	RowsCollection = require './RowsCollection'
	PaginationModel = require './PaginationModel'
	ColumnsModel = require './ColumnsModel'


	class TableModel extends Model

		defaults:
			transposed: false
			showAll: true
			columns: []

		listen:
			'@rowsCollection change:checked add remove reset': 'updateChecked'
			'@rowsCollection change:checked': 'onChangeChecked'
			'@ change:showAll': 'updateShowAll'

			'sub row:uncheck': 'uncheckRow'
			'sub stats:update': 'onStatsUpdate'
			'sub table:update': 'onUpdate'

		initialize: ->
			@paginationModel = new PaginationModel
			@columnsModel = new ColumnsModel null, paginationModel: @paginationModel
			@rowsCollection = new RowsCollection null, paginationModel: @paginationModel


		onStatsUpdate: (response) ->
			@updateTable response
			@updateColumns response
			@updateRows response

			@onUpdate()

			@precheckRows()


		updateRows: (response) ->
			@rowsCollection.model::defaults.numFormat = @_getNumFormat()
			@rowsCollection.reset response.series


		precheckRows: ->
			if @get 'isDateTime'
				@rowsCollection.getTotalRow().check true
			else
				for row in @rowsCollection.getOrdinaryRows().slice(0, 5)
					row.check true


		_getNumFormat: ->
			switch @get 'dataType'
				when 'ctr'
					precision : 2
					thousand : ' '
					decimal : '.'
				else
					precision : 0
					thousand : ' '
					decimal : '.'


		updateTable: (response) ->
			@set isDateTime: response.isDateTime
			@set section: response.section
			@set category: response.category
			@set dataType: response.dataType
			@set transposed: false


		updateColumns: (response) ->
			@columnsModel.set isDateTime: response.isDateTime
			@columnsModel.set columns: response.columns
			@columnsModel.set detail: response.detail


		onChangeChecked: (rowModel, changes, options) ->
			unless options.dontpub
				if rowModel.get 'checked'
					@publishEvent 'row:checked', rowModel
				else
					@publishEvent 'row:unchecked', rowModel


		onUpdate: ->
			@publishEvent 'table:updated', this


		checkAll: (checked = true) ->
			@rowsCollection.checkAll checked


		uncheckRow: (id) ->
			@rowsCollection.uncheckRow id


		updateChecked: ->
			@set checkedCount: @rowsCollection.getCheckedRows().length
			@set allChecked: @rowsCollection.isAllChecked()

			@updateShowAll()


		updateShowAll: ->
			showAll =  @get('showAll')
			if showAll
				@rowsCollection.each (row) ->
					row.set hide: false
			else
				@rowsCollection.each (row) ->
					row.set hide: !row.get('checked')


		sortBy: (attr, directOrder = true) ->
			@set sortAttr: attr
			@set directOrder: directOrder

			@rowsCollection.comparator = (model1, model2) ->
				value1 = model1.get attr
				value2 = model2.get attr

				if directOrder
					[value1, value2] = [value2, value1]

				if value1 > value2
					1
				else
					-1

			@rowsCollection.sort()


		transpose: ->
			rows = @rowsCollection.getOrdinaryRows()
			columns = @columnsModel.getColumns()

			[newColumns, data] = @_getNamesAndData(rows)
			newData = @_T(data)

			newRows = @_concatNamesAndData(columns, newData)

			@_reset(newColumns, newRows)
			@toggleAttr 'transposed'
			@onUpdate()


		_reset: (columns, rows) ->
			@rowsCollection.reset rows
			@columnsModel.set columns: columns


		_concatNamesAndData: (names, data) ->
			res = []

			i = -1
			while ++i < names.length
				el =
					id: names[i].id
					name: names[i].name
					data: data[i]

				res.push(el)

			res


		_T: (data) ->
			res = []
			[y, x] = @_size(data)

			i = -1
			while ++i < x
				res[i] = []

				j = -1
				while ++j < y
					res[i][j] = data[j][i]

			res


		_size: (data) ->
			x = data[0].length
			y = data.length

			[y, x]


		_getNamesAndData: (rows) ->
			names = []
			data = []

			for row in rows
				name =
					name: row.get('name')
					id: row.get('id')

				names.push name
				data.push row.get('data')

			[names, data]

