define (require) ->
	_ = require '_'
	Model = require 'Model'


	class RowModel extends Model

		defaults:
			checked: false

		initialize: ->
			@listenTo this, 'change:data', @calcAttr
			@calcAttr()


		calcAttr: ->
			@set average: @getAverage()
			@set total: @getTotal()


		getTotal: ->
			_.reduce @get('data'), ((memo, cell) -> memo + cell), 0


		getAverage: ->
			Math.round @getTotal() / @getLength()


		getLength: ->
			@get('data').length


		check: (checked = true, options) ->
			@set checked: checked, options