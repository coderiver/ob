define (require) ->
	View = require 'View'
	template = require 'tpl!templates/table/top/transpose.html'


	class TransposeView extends View

		className: 'choice-tabs'

		template: template

		events:
			'click @first': 'onClickFirst'
			'click @second': 'onClickSecond'

		initialize: ->
			@listenTo @model, 'change:transposed', @renderCurrent
			@listenTo @model, 'change', @render


		serialize: ->
			first = switch @model.get 'category'
				when 'country' then 'Страны'
				when 'operator' then 'Операторы'
				when 'platform' then 'Платформы'
				when 'vendor' then 'Производители'

			second = switch @model.get 'section'
				when 'campaigns' then 'Кампании'
				when 'banners' then 'Объявления'
				when 'sites' then 'Площадки'

			first: first
			second: second


		_render: ->
			@renderCurrent()


		renderCurrent: ->
			if @model.get 'transposed'
				@$('@first').addClass('active')
				@$('@second').removeClass('active')
			else
				@$('@first').removeClass('active')
				@$('@second').addClass('active')


		onClickFirst: (event) ->
			event.preventDefault()
			event.stopPropagation()
			unless @model.get 'transposed'
				@model.transpose()


		onClickSecond: (event) ->
			event.preventDefault()
			event.stopPropagation()
			if @model.get 'transposed'
				@model.transpose()

