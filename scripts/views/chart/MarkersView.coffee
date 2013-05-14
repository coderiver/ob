define (require) ->
	View = require 'View'
	MarkerView = require './MarkerView'


	class MarkersView extends View

		listen:
			'@collection reset': 'render'
			'@collection add': 'addMarker'

		render: ->
			@clear()
			@collection.each @addMarker, this


		addMarker: (seriesModel) ->
			markerView = new MarkerView
				model: seriesModel

			@append markerView