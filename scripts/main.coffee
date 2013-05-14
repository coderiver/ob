define (require) ->
	require 'jquery_role'

	AnalyticsView = require 'views/AnalyticsView'


	new AnalyticsView(el: '@analytics')

