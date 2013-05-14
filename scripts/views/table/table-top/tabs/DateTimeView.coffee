define (require) ->
	View = require 'View'
	SwitchView = require './SwitchView'
	textTemplate = require 'tpl!templates/table/top/title.html'


	class DateTimeView extends View

		render: ->
			@append new SwitchView(model: @model)
			@renderText()


		renderText: ->
			@$el.append textTemplate()
