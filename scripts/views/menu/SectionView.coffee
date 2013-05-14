define (require) ->
	$ = require '$'
	View = require 'View'


	class SectionView extends View

		events:
			'click @toggle': 'toggleDropdown'
			'click .category__list li': 'changeSection'

		initialize: ->
			@listenTo @model, 'change:section', @render


		render: ->
			@setCurrent @model.get('section')


		setCurrent: (name) ->
			@_swapElements @getPointByName(name), @$('@toggle').find('span')


		getPointByName: (name) ->
			@$ "span[data-name=#{ name }]"


		toggleDropdown: (event) ->
			event.stopPropagation()
			event.preventDefault()
			@showDropdown not @$('@toggle').hasClass('category__selected_open')


		showDropdown: (show) ->
			target = @$ '@toggle'
			target.next('.category__drop').toggle show
			target.toggleClass 'category__selected_open', show


		changeSection: (event) ->
			event.stopPropagation()
			event.preventDefault()

			target = $(event.currentTarget).find('span')
			@model.set section: target.data('name')

			@_swapElements @$('@toggle').find('span'), target
			@showDropdown false


		_swapElements: (a, b) ->
			copy_a = a.clone true
			copy_b = b.clone true
			a.replaceWith copy_b
			b.replaceWith copy_a
