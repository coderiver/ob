define (require) ->
	View = require 'View'
	DateTimeView = require './DateTimeView'
	ColumnsView = require './ColumnsView'


	class TabsView extends View

		initialize: ->
			@listenTo @model, 'change:isDateTime', @renderSwitch


		render: ->
			@renderSwitch()


		renderSwitch: ->
			if @model.get 'isDateTime'
				@switchDateTime()
			else
				@switchColumns()


		switchView: (view) ->
			@_view?.dispose()
			@_view = view
			@append view


		switchDateTime: ->
			@switchView new DateTimeView(model: @model)


		switchColumns: ->
			@switchView new ColumnsView(model: @model)
