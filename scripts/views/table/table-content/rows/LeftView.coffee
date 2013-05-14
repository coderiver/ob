define (require) ->
	View = require 'View'
	template = require 'tpl!templates/table/rows/left.html'


	class LeftView extends View

		template: template

		tagName: 'tr'

		events:
			'click @checkbox': 'onChangeCheckbox'
			'click @checkbox-wrap': 'onWrapClick'

		initialize: ->
			@listenTo @model, 'change:checked', @renderChecked
			@listenTo @model, 'change:hide', @renderHide


		_render: ->
			@renderHide()
			@renderChecked()


		renderChecked: ->
			@$('@checkbox').prop 'checked', @model.get('checked')


		renderHide: ->
			@$el.toggle !@model.get('hide')


		onWrapClick: (event) =>
			event.stopPropagation()
			@$('@checkbox').trigger('click')


		onChangeCheckbox: (event) =>
			event.stopPropagation()
			@model.check @_isEventChecked(event)


		_isEventChecked: (event) ->
			$(event.target).is(':checked')
