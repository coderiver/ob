define (require) ->
	require 'jquery_datepicker'
	View = require 'View'


	class DatepickerView extends View

		initialize: ->
			@listenTo @model, 'change:range', @renderRange

		render: ->
			@$el.DatePicker @getOptions()


		renderRange: (model, value, options) ->
			unless options.lock
				@setDate @model.get('range'), true


		getOptions: ->
			flat: true
			date: @model.get('range')
			current: @model.get('end')
			calendars: 2
			mode: 'range'
			starts: 1

			locale:
				days: ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота']
				daysShort: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб']
				daysMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб']
				months: [
					'Январь', 'Февраль', 'Март', 'Апрель'
					'Май', 'Июнь', 'Июль', 'Август'
					'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'
				]
				monthsShort: [
					'Янв', 'Фев', 'Мар', 'Апр'
					'Май', 'Июн', 'Июл', 'Авг'
					'Сен', 'Окт', 'Ноя', 'Дек'
				]
				weekMin: 'Нд'

			onRender: @onPickerRender
			onChange: @onPickerChange


		setDate: (date, shiftTo = false) ->
			@$el.DatePickerSetDate date, shiftTo


		getDate: (formated = false) ->
			@$el.DatePickerGetDate formated


		onPickerRender: (date) ->
			disabled: date.valueOf() > (new Date()).valueOf()


		onPickerChange: (formatedDate, rawDate) =>
			@model.set range: rawDate, {lock: true}




