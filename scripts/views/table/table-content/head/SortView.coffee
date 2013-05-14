define (require) ->
	View = require 'View'


	class SortView extends View

		events:
			'click @reverse': 'sortReverse'
			'click @direct': 'sortDirect'

		initialize: (options) ->
			@sortAttr = options.sortAttr

			@listenTo @model, 'change:sortAttr change:directOrder', @render


		render: ->
			@renderSort()


		renderSort: ->
			showDirect = true
			showReverse = true

			if @model.get('sortAttr') == @sortAttr
				if @model.get('directOrder')
					showDirect = false
				else
					showReverse = false

			@$('@direct').toggle(showDirect)
			@$('@reverse').toggle(showReverse)


		sortDirect: ->
			@model.sortBy @sortAttr, true


		sortReverse: ->
			@model.sortBy @sortAttr, false




