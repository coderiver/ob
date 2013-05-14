define (require) ->
	$ = require '$'
	Model = require 'Model'


	class PaginationModel extends Model

		defaults:
			count: 0
			offset: 0
			rowLength: 0
			canNext: false
			canPrev: false

		minColumnWidth: 90

		initialize: ->
			$(window).resize @calcAttrs

			@listenTo this, 'change:rowLength', @onReset
			@listenTo this, 'change:offset', @calcCan


		onReset: ->
			@set offset: 0
			@calcAttrs()


		calcAttrs: =>
			width = $('@table-center').width()
			@calcVisibleCount(width)
			@calcCan()


		calcVisibleCount: (width) ->
			@set count: Math.floor(width / @minColumnWidth)


		calcCan: ->
			offset = @get('offset')
			endOffset = offset + @get('count')

			@set canPrev: offset > 0
			@set canNext: endOffset < @get('rowLength')


		prevPage: ->
			@unary 'offset', (val) -> val - 1


		nextPage: ->
			@unary 'offset', (val) -> val + 1


		_sliceData: (data) ->
			offset = @get 'offset'
			count = @get 'count'

			data.slice offset, offset + count


