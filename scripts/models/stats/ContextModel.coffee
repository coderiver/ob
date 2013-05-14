define (require) ->
	Model = require 'Model'


	class ContextModel extends Model

		defaults:
			section: 'campaigns'
			category: 'common'
			type: 'impression'

		isDateTime: ->
			@get('category') == 'common'


		initialize: ->
			# todo Убрать, когда будет готово Stats pub
			@listenTo this, 'change:category', =>
				@publishEvent 'category', this