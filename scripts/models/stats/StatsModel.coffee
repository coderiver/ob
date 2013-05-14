define (require) ->
	Model = require 'Model'
	ContextModel = require './ContextModel'
	CalendarModel = require './CalendarModel'


	class StatsModel extends Model

		url: '/stats'

		initialize: ->
			@contextModel = new ContextModel()
			@calendarModel = new CalendarModel()

			@listenTo @contextModel, 'change', @fetch
			@listenTo @calendarModel, 'change', @fetch


		getRequestParams: ->
			@contextModel.toJSON()


		fetch: ->
			super data: @getRequestParams()


		parse: (response) ->
			response.section = @contextModel.get 'section'
			response.category = @contextModel.get 'category'
			response.dataType = @contextModel.get 'type'
			response.isDateTime = @contextModel.isDateTime()
			response.detail = @calendarModel.get 'detail'

			@publishEvent 'stats:update', response
