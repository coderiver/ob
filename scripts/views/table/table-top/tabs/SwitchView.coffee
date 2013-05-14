define (require) ->
	View = require 'View'
	CheckedCountView = require './CheckedCountView'
	template = require 'tpl!templates/table/top/switch.html'


	class SwitchView extends View

		template: template

		className: 'choice-tabs'

		events:
			'click @show-checked': 'showChecked'
			'click @show-all': 'showAll'

		initialize: ->
			@listenTo @model, 'change:showAll', @renderButtons
			@listenTo @model, 'change:checkedCount', @preventShowNothing
			@listenTo @model, 'change:section change:category change:transposed', @render


		serialize: ->
			text: @getText()


		getText: ->
			unless @model.get 'transposed'
				switch @model.get('section')
					when 'campaigns' then 'Все кампании'
					when 'banners' then 'Все объявления'
					else 'Все площадки'
			else
				switch @model.get 'category'
					when 'country' then 'Все страны'
					when 'operator' then 'Все операторы'
					when 'platform' then 'Все платформы'
					else 'Все производители'


		_render: ->
			@add '@checked-count', CheckedCountView, model: @model
			@renderButtons()


		renderButtons: ->
			if @model.get 'showAll'
				@$('@show-all').addClass('active')
				@$('@show-checked').removeClass('active')
			else
				@$('@show-all').removeClass('active')
				@$('@show-checked').addClass('active')


		showChecked: (event) ->
			event.preventDefault()
			if @model.get 'checkedCount'
				@model.set showAll: false


		showAll: ->
			event.preventDefault()
			@model.set showAll: true


		preventShowNothing: ->
			unless @model.get 'checkedCount'
				@model.set showAll: true



