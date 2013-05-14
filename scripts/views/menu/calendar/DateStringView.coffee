define (require) ->
	View = require 'View'
	moment = require('utils').moment


	class DateStringView extends View

		format: 'DD.MM.YY'

		initialize: ->
			@listenTo @model, 'change:range', @render


		render: ->
			range = @model.get 'range'
			start = range[0]
			end = range[1]

			@$el.html "#{ moment(start).format(@format) } - #{ moment(end).format(@format) }"