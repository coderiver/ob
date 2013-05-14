define (require) ->
	View = require 'View'
	TabsView = require './tabs/TabsView'
	ButtonsView = require './ButtonsView'


	class TableTopView extends View

		render: ->
			@add '@tabs', TabsView, model: @model
			@add '@buttons', ButtonsView


