define (require) ->
	View = require 'View'
	SwitchView = require './SwitchView'
	TransposeView = require './TransposeView'


	class ColumnsView extends View

		render: ->
			@append new TransposeView(model: @model)
			@append new SwitchView(model: @model)

