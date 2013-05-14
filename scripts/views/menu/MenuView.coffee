define (require) ->
	View = require 'View'
	SectionView = require './SectionView'
	CategoryView = require './CategoryView'
	DataMenuView = require './DataMenuView'
	DetailView = require './DetailView'
	CalendarView = require './calendar/CalendarView'


	class MenuView extends View

		render: ->
			@add '@section', SectionView, model: @model.contextModel
			@add '@category', CategoryView, model: @model.contextModel
			@add '@data-menu', DataMenuView, model: @model.contextModel
			@add '@detail', DetailView, model: @model.calendarModel
			@add '@calendar', CalendarView, model: @model.calendarModel

