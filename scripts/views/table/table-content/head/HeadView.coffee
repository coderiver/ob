define (require) ->
	View = require 'View'
	LeftView = require './LeftView'
	CenterView = require './CenterView'
	RightView = require './RightView'


	class HeadView extends View

		render: ->
			@add '@left', LeftView, model: @model
			@add '@center', CenterView, model: @model.columnsModel
			@add '@right', RightView, model: @model






