define (require) ->
	View = require 'View'


	class CheckAllView extends View

		events:
			'click @check-all': 'checkAll'
			'click': 'onWrapClick'

		initialize: ->
			@listenTo @model, 'change:allChecked', @render


		render: ->
			@$('@check-all').prop 'checked', @model.get('allChecked')


		onWrapClick: (event) =>
			event.stopPropagation()
			@$('@check-all').trigger('click')


		checkAll: (event) =>
			event.stopPropagation()
			@model.checkAll @_isEventChecked(event)


		_isEventChecked: (event) ->
			$(event.target).is(':checked')