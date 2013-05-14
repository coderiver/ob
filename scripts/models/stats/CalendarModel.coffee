define (require) ->
	Model = require 'Model'
	moment = require('utils').moment


	class CalendarModel extends Model

		defaults:
			range: [new Date(), new Date()]
			detail: 'month'
			auto: true

		setToday: ->
			@setRange moment().toDate()


		setYesterday: ->
			@setRange moment().subtract('days', 1).toDate()


		setSevenDays: ->
			@setRange(
				moment().subtract('days', 6).toDate()
				moment().toDate()
			)


		setWeek: ->
			@setRange(
				moment().startOf('week').add('days', 1).toDate()
				moment().toDate()
			)


		setMonth: ->
			@setRange(
				moment().startOf('month').toDate()
				moment().toDate()
			)


		setLastMonth: ->
			@setRange(
				moment().startOf('month').subtract('month', 1).toDate()
				moment().startOf('month').subtract('days', 1).toDate()
			)


		setQuarter: ->
			month = moment().month()
			quarter = Math.floor(month / 3)

			@setRange(
				moment().month(quarter * 3).date(1).hours(0).minutes(0).seconds(0).milliseconds(0).toDate()
				moment().toDate()
			)


		setYear: ->
			@setRange moment().startOf('year').toDate(), moment().toDate()


		setAllTime: ->


		setRange: (start, end = start) ->
			@set range: [start, end]




