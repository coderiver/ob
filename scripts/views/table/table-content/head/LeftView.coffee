define (require) ->
	View = require 'View'
	CheckAllView = require './CheckAllView'
	SortView = require './SortView'


	class LeftView extends View

		initialize: ->
			@listenTo @model, 'change:section change:category change:transposed', @renderName


		render: ->
			@add '@check-all-wrap', CheckAllView, model: @model
			@add '@sort-by-name', SortView, {model: @model, sortAttr: 'name'}
			@renderName()


		renderName: ->
			@$('@name').html @getName()


		getName: ->
			unless @model.get 'transposed'
				switch @model.get('section')
					when 'campaigns' then 'Кампания'
					when 'banners' then 'Объявление'
					else 'Площадка'
			else
				switch @model.get 'category'
					when 'country' then 'Страны'
					when 'operator' then 'Операторы'
					when 'platform' then 'Платформы'
					else 'Производители'