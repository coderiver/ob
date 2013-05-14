define (require) ->
	View = require 'View'


	class PageButtonView extends View

		events:
			'click': 'onClick'

		initialize: ->
			@listenTo @model, "change:#{@options.attrName}", @render


		render: ->
			@$el.toggle @model.get(@options.attrName)


		onClick: (event) ->
			event.stopPropagation()
			@model[@options.onClickName]()