define (require) ->
	View = require 'View'
	SortView = require './SortView'


	class RightView extends View

		render: ->
			@add '@sort-by-average', SortView, {model: @model, sortAttr: 'average'}
			@add '@sort-by-total', SortView, {model: @model, sortAttr: 'total'}