define (require) ->
	View = require 'View'
	template = require 'tpl!templates/data-menu.html'


	class DataMenuView extends View

		template: template

		events:
			'click li': 'changeType'

		initialize: ->
			@listenTo @model, 'change:section', @render
			@listenTo @model, 'change:category', @renderShow
			@listenTo @model, 'change:type', @renderSelect


		serialize: ->
			costName: if @model.get('section') == 'sites' then 'Доходы' else 'Расходы'


		_render: ->
			@renderShow()
			@renderSelect()


		renderSelect: ->
			@deselecAll()
			@select @model.get('type')


		renderShow: ->
			# Меню есть только для Общее, для остальных только просмотры
			show = @model.get('category') == 'common'
			@$el.toggle show


		select: (name) ->
			@$("[data-name=#{ name }]").addClass('active')


		deselecAll: ->
			@$('li').removeClass('active')


		changeType: (event) ->
			event.stopPropagation()
			event.preventDefault()
			@model.set type: $(event.currentTarget).data('name')
