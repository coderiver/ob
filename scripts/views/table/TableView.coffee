define (require) ->
	View = require 'View'
	TableTopView = require './table-top/TableTopView'
	TableContentView = require './table-content/TableContentView'


	class TableView extends View

		render: ->
			@add '@table-top', TableTopView, model: @model
			@add '@table-content', TableContentView, model: @model