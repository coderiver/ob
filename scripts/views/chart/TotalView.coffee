define (require) ->
	View = require 'View'
	utils = require 'utils'


	class TotalView extends View

		listen:
			'@collection reset add remove': 'render'

		serialize: ->
			total = @collection.getTotal()
			"Всего: #{ utils.accounting.formatNumber(total, 0, ' ') }"

		render: ->
			@$el.html @serialize()