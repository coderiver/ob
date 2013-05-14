define (require) ->
	View = require 'View'
	template = require 'tpl!templates/chart/marker.html'


	class MarkerView extends View

		className: 'marker'

		template: template

		events:
			'click @close': 'close'
			'mouseenter': 'mouseenter'
			'mouseleave': 'mouseleave'

		listen:
			'@model remove': 'remove'

		close: (event) ->
			event.stopPropagation()
			@publishEvent 'row:uncheck', @model.id


		mouseenter: (event) ->
			event.stopPropagation()
			@model.select()


		mouseleave: (event) ->
			event.stopPropagation()
			@model.deselect()



