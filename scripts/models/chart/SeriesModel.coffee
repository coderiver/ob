define (require) ->
	Model = require 'Model'


	class SeriesModel extends Model

		defaults:
			color: '#aaa'

		select: ->
			@set selected: true


		deselect: ->
			@set selected: false


		check: (checked) ->
			@set checked: checked


		isChecked: ->
			@get 'checked'


		setDefaultColor: ->
			@set color: @defaults.color
