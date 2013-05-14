define (require) ->
	moment = require('utils').moment
	_ = require '_'
	Model = require 'Model'


	class ColumnsModel extends Model

		defaults:
			detail: 'day'
			isDateTime: true
			columns: []

		detailFormat:
			hour:  little: 'HH',   big: 'D MMM', chart: 'HH'
			day:   little: 'D',    big: 'MMM',   chart: 'D'
			week:  little: 'wo',   big: 'MMMM',  chart: 'wo'
			month: little: 'MMMM', big: 'YYYY',  chart: 'MMM'
			year:  little: 'YYYY', big: 'YYYY',  chart: 'YYYY'

		initialize: (attributes, options) ->
			@paginationModel = options.paginationModel


		isDateTime: ->
			@get 'isDateTime'


		getHeadData: ->
			if @isDateTime()
				big: @getBig()
				little: @getLittle()
			else
				raw: @getRaw()


		getBig: ->
			names = @format @getRaw(), 'big'
			@_getUniqCounts names


		_getUniqCounts: (arr) ->
			uniq = _.uniq arr, true

			count = for item in uniq
				@_getCount item, arr

			zipped = _.zip uniq, count

			for item in zipped
				name: item[0]
				count: item[1]


		_getCount: (item, arr) ->
			filtered = _.filter arr, (el) ->
				el == item

			filtered.length


		getLittle: ->
			@format @getRaw(), 'little'


		getRaw: ->
			@_slice @getNames()


		_slice: (data) ->
			@paginationModel._sliceData(data)


		format: (dates, detail) ->
			@_format dates, @_getFormat()[detail]


		_format: (dates, pattern) ->
			for date in dates
				moment(date).format pattern


		_getFormat: ->
			@detailFormat[@get('detail')]


		getChartCategories: ->
			names = @getNames()
			if @isDateTime()
				@format names, 'chart'
			else
				names


		getNames: ->
			if @isDateTime()
				@getColumns()
			else
				_.pluck @getColumns(), 'name'


		getColumns: ->
			@get 'columns'