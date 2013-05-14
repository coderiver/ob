define (require) ->
	$ = require '$'
	View = require 'View'


	class CategoryView extends View

		events:
			'click li': 'changeCategory'

		initialize: ->
			@listenTo @model, 'change:category', @render


		render: ->
			@deselecAll()
			@select @model.get('category')


		select: (name) ->
			@$("[data-name=#{ name }]").addClass('active')


		deselecAll: ->
			@$('li').removeClass('active')


		changeCategory: (event) ->
			event.stopPropagation()
			event.preventDefault()
			@model.set category: $(event.currentTarget).data('name')



