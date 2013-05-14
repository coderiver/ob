define (require) ->
	View = require 'View'
	DateStringView = require './DateStringView'
	DatePickerView = require './DatePickerView'
	RangePresetView = require './RangePresetView'


	class CalendarView extends View
		# todo toggle Переделать нормально
		events:
			'click .select-date__in': 'toggle'

		render: ->
			@add '@date-string', DateStringView, model: @model
			@add '@date-picker', DatePickerView, model: @model
			@add '@range-preset', RangePresetView, model: @model


		toggle: ->
			@$el.toggleClass 'is-active'