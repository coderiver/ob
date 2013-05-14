define (require) ->
	$ = require '$'
	View = require 'View'


	class DetailView extends View

		events:
			'click': 'toggleDropdown'
			'click @auto': 'selectAuto'
			'click @dropdown li[data-name]': 'selectItem'

		initialize: ->
			@listenTo @model, 'change:detail change:auto', @render


		render: ->
			@deselectAll()
			@renderSelect()


		renderSelect: ->
			if @model.get 'auto'
				@switchItem @$('@auto')
			else
				@selectByName @model.get('detail')


		selectByName: (name) ->
			el = @getByName name
			@switchItem el


		switchItem: (el) ->
			@$('@title').html el.html()
			el.hide()


		getByName: (name) ->
			@$ "li[data-name=#{ name }]"


		deselectAll: ->
			@$('li').show()


		toggleDropdown: (event) ->
			event.stopPropagation()
			event.preventDefault()
			@$el.toggleClass 'is-dropped'


		selectItem: (event) ->
			event.preventDefault()
			@model.set auto: false
			@model.set detail: $(event.currentTarget).data('name')


		selectAuto: (event) ->
			event.preventDefault()
			@model.set auto: true