define (require) ->
	View = require 'View'


	class RangePresetView extends View

		events:
			'click @today': 'setToday'
			'click @yesterday': 'setYesterday'
			'click @seven-days': 'setSevenDays'
			'click @week': 'setWeek'
			'click @month': 'setMonth'
			'click @last-month': 'setLastMonth'
			'click @quarter': 'setQuarter'
			'click @year': 'setYear'
			'click @all-time': 'setAllTime'

		render: ->


		setToday: (event) ->
			event.preventDefault()
			event.stopPropagation()
			@model.setToday()


		setYesterday: (event) ->
			event.preventDefault()
			event.stopPropagation()
			@model.setYesterday()


		setSevenDays: (event) ->
			event.preventDefault()
			event.stopPropagation()
			@model.setSevenDays()


		setWeek: (event) ->
			event.preventDefault()
			event.stopPropagation()
			@model.setWeek()


		setMonth: (event) ->
			event.preventDefault()
			event.stopPropagation()
			@model.setMonth()


		setLastMonth: (event) ->
			event.preventDefault()
			event.stopPropagation()
			@model.setLastMonth()


		setQuarter: (event) ->
			event.preventDefault()
			event.stopPropagation()
			@model.setQuarter()


		setYear: (event) ->
			event.preventDefault()
			event.stopPropagation()
			@model.setYear()


		setAllTime: (event) ->
			event.preventDefault()
			event.stopPropagation()
			@model.setAllTime()