define (require) ->
	View = require 'View'
	RowsView = require './rows/RowsView'
	HeadView = require './head/HeadView'
	PageButtonView = require './PageButtonView'


	class TableContentView extends View

		render: ->
			@add '@rows', RowsView, collection: @model.rowsCollection
			@add '@head', HeadView, model: @model

			@add '@prev', PageButtonView,
				model: @model.paginationModel
				attrName: 'canPrev'
				onClickName: 'prevPage'

			@add '@next', PageButtonView,
				model: @model.paginationModel
				attrName: 'canNext'
				onClickName: 'nextPage'
