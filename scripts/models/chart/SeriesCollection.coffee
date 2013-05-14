define (require) ->
	Collection = require 'Collection'
	SeriesModel = require './SeriesModel'
	CheckedCollection = require './CheckedCollection'


	class SeriesCollection extends Collection

		model: SeriesModel

		listen:
			'sub row:checked': 'onRowChecked'
			'sub row:unchecked': 'onRowUnchecked'
			'sub table:updated': 'onTableUpdated'
			'@ change:checked': 'onChangeChecked'

		initialize: ->
			@checkedCollection = new CheckedCollection


		onRowChecked: (rowModel) ->
			@get(rowModel.id).check true


		onRowUnchecked: (rowModel) ->
			@get(rowModel.id).check false


		onTableUpdated: (tableModel) ->
			@columnsModel = tableModel.columnsModel
			@reset tableModel.rowsCollection.invoke('toJSON')

			@updateChecked()


		updateChecked: ->
			@checkedCollection.columnsModel = @columnsModel
			@checkedCollection.reset @getCheckedRows()


		getCheckedRows: ->
			@filter (row) -> row.isChecked()


		getOrdinaryRows: ->
			@filter (row) ->
				not row.id? or row.id > -1


		onChangeChecked: (model) ->
			if model.isChecked()
				@checkedCollection.add model
			else
				@checkedCollection.remove model.id







