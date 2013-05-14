define (require) ->
	View = require 'View'


	class ButtonsView extends View

		events:
			'click @toggle-chart': 'toggleChart'

		render: ->


		toggleChart: (event) ->
			event.preventDefault()
			event.stopPropagation()
			@publishEvent 'chart:toggle'