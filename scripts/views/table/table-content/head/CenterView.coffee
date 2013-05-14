define (require) ->
	View = require 'View'
	templateRaw = require 'tpl!templates/table/head/raw.html'
	templateDate = require 'tpl!templates/table/head/date.html'


	class CenterView extends View

		initialize: ->
			@listenTo @model, 'change', @render
			@listenTo @model.paginationModel, 'change:offset change:count', @render


		serialize: ->
			@model.getHeadData()


		_render: ->
			data = @serialize()
			if @model.get 'isDateTime'
				@$el.html templateDate(data)
			else
				@$el.html templateRaw(data)
