# coding: utf-8

require 'rubygems'
require 'compass'
require 'sinatra'
require 'sass'
require 'coffee-script'
require 'json'

set :public_folder, settings.root
set :views, settings.root

c = Compass.configuration
c.sass_dir = 'styles'
c.images_dir = 'images'
c.http_path = '/'
c.http_images_path = '/images'
c.http_stylesheets_path = '/styles'


get '/*.css' do |filename|
	content_type 'text/css', :charset => 'utf-8'

	Sass.compile_file File.join(settings.root, filename + '.scss'), Compass.sass_engine_options
end

get '/*.js' do |filename|
	content_type 'application/javascript', :charset => 'utf-8'

	io = File.read File.join(settings.root, filename + '.coffee')
	CoffeeScript.compile io
end

$stats = {
	:common => {
		:impression => {
			:columns => [
				'Янв 2012', 'Фев 2012', 'Мар 2012', 'Апр 2012',
				'Май 2012', 'Июн 2012', 'Июл 2012', 'Авг 2012',
				'Сен 2012', 'Окт 2012', 'Ноя 2012', 'Дек 2012',
				'Янв 2013', 'Фев 2013', 'Мар 2013'],
			:series => [
				{:id => 1, :name => 'Реклама для каналов', :data => [150, 410, 605, 395, 570, 860, 220, 570, 460, 605, 1050, 670, 900, 320, 650]},
				{:id => 2, :name => 'Colins Collection', :data => [100, 805, 910, 250, 560, 800, 190, 1000, 410, 605, 395, 570, 860, 220, 100]},
				{:id => 5, :name => 'Ipad Ad', :data => [460, 605, 1050, 670, 900, 320, 650, 700, 560, 800, 190, 1000, 410, 605, 245]},

				{:id => 10, :name => 'Реклама для каналов1', :data => [150, 410, 605, 395, 570, 860, 220, 570, 460, 605, 1050, 670, 900, 320, 650]},
				{:id => 20, :name => 'Colins Collection1', :data => [100, 805, 910, 250, 560, 800, 190, 1000, 410, 605, 395, 570, 860, 220, 100]},
				{:id => 50, :name => 'Ipad Ad1', :data => [460, 605, 1050, 670, 900, 320, 650, 700, 560, 800, 190, 1000, 410, 605, 245]},
				{:id => 12, :name => 'Реклама для каналов2', :data => [150, 410, 605, 395, 570, 860, 220, 570, 460, 605, 1050, 670, 900, 320, 650]},
				{:id => 22, :name => 'Colins Collection2', :data => [100, 805, 910, 250, 560, 800, 190, 1000, 410, 605, 395, 570, 860, 220, 100]},
				{:id => 52, :name => 'Ipad Ad2', :data => [460, 605, 1050, 670, 900, 320, 650, 700, 560, 800, 190, 1000, 410, 605, 245]},
				{:id => 13, :name => 'Реклама для каналов3', :data => [150, 410, 605, 395, 570, 860, 220, 570, 460, 605, 1050, 670, 900, 320, 650]},
				{:id => 23, :name => 'Colins Collection3', :data => [100, 805, 910, 250, 560, 800, 190, 1000, 410, 605, 395, 570, 860, 220, 100]},
				{:id => 53, :name => 'Ipad Ad3', :data => [460, 605, 1050, 670, 900, 320, 650, 700, 560, 800, 190, 1000, 410, 605, 245]},

				{:id => 101, :name => 'Реклама для каналов11', :data => [150, 410, 605, 395, 570, 860, 220, 570, 460, 605, 1050, 670, 900, 320, 650]},
				{:id => 201, :name => 'Colins Collection11', :data => [100, 805, 910, 250, 560, 800, 190, 1000, 410, 605, 395, 570, 860, 220, 100]},
				{:id => 501, :name => 'Ipad Ad11', :data => [460, 605, 1050, 670, 900, 320, 650, 700, 560, 800, 190, 1000, 410, 605, 245]},
				{:id => 121, :name => 'Реклама для каналов21', :data => [150, 410, 605, 395, 570, 860, 220, 570, 460, 605, 1050, 670, 900, 320, 650]},
				{:id => 221, :name => 'Colins Collection21', :data => [100, 805, 910, 250, 560, 800, 190, 1000, 410, 605, 395, 570, 860, 220, 100]},
				{:id => 521, :name => 'Ipad Ad21', :data => [460, 605, 1050, 670, 900, 320, 650, 700, 560, 800, 190, 1000, 410, 605, 245]},
				{:id => 131, :name => 'Реклама для каналов31', :data => [150, 410, 605, 395, 570, 860, 220, 570, 460, 605, 1050, 670, 900, 320, 650]},
				{:id => 231, :name => 'Colins Collection31', :data => [100, 805, 910, 250, 560, 800, 190, 1000, 410, 605, 395, 570, 860, 220, 100]},
				{:id => 531, :name => 'Ipad Ad31', :data => [460, 605, 1050, 670, 900, 320, 650, 700, 560, 800, 190, 1000, 410, 605, 245]}
			]
		},


		:click => {
			:columns => [
				'2012-08', '2012-09', '2012-10', '2012-11',
				'2012-12', '2013-01', '2013-02', '2013-03'],
			:series => [
				{:id => 1, :name => 'Реклама для каналов', :data => [50, 210, 305, 195, 270, 360, 420, 470]},
				{:id => 2, :name => 'Colins Collection', :data => [100, 105, 210, 150, 160, 400, 390, 200]},
				{:id => 5, :name => 'Ipad Ad', :data => [160, 405, 350, 170, 100, 220, 350, 100]}
			]
		},

		:ctr => {
			:columns => [
				'2012-08', '2012-09', '2012-10', '2012-11',
				'2012-12', '2013-01', '2013-02', '2013-03'],
			:series => [
				{:id => 1, :name => 'Реклама для каналов', :data => [1, 0.12, 3, 0.5, 0.6, 0.11, 0.1, 0.01]},
				{:id => 2, :name => 'Colins Collection', :data => [2, 1, 3, 5, 3, 2, 1.5, 0.5]},
				{:id => 5, :name => 'Ipad Ad', :data => [3, 4, 1, 0.04, 0.5, 0.1, 0.3, 0.3]}
			]
		},

		:money => {
			:columns => [
				'2012-08', '2012-09', '2012-10', '2012-11',
				'2012-12', '2013-01', '2013-02', '2013-03'
			],
			:series => [
				{:id => 1, :name => 'Реклама для каналов', :data => [10, 120, 30, 50, 60, 110, 10, 16]},
				{:id => 2, :name => 'Colins Collection', :data => [24, 15, 33, 57, 36, 25, 15, 25]},
				{:id => 5, :name => 'Ipad Ad', :data => [31, 42, 13, 44, 55, 16, 37, 39]}
			]
		},
	},

	:country => {
		:columns => [
			{:id => 31, :name => 'Россия'},
			{:id => 32, :name => 'Украина'},
			{:id => 33, :name => 'Казахстан'},
			{:id => 34, :name => 'Туркменистан'},
			{:id => 35, :name => 'Вьетнам'}
		],
		:series => [
			{:id => 1, :name => 'Реклама для каналов', :data => [150, 400, 500, 200, 100]},
			{:id => 2, :name => 'Colins Collection', :data => [300, 300, 400, 300, 500]},
			{:id => 5, :name => 'Ipad Ad', :data => [450, 185, 345, 440, 435]}
		]
	},

	:operator => {
		:columns => [
			{:id => 11, :name => 'Оператор 1'},
			{:id => 12, :name => 'Оператор 2'},
			{:id => 13, :name => 'Оператор 3'},
			{:id => 14, :name => 'Оператор 4'}
		],
		:series => [
			{:id => 1, :name => 'Реклама для каналов', :data => [150, 400, 500, 200]},
			{:id => 2, :name => 'Colins Collection', :data => [300, 300, 400, 300]},
			{:id => 5, :name => 'Ipad Ad', :data => [450, 185, 345, 440]}
		]
	},

	:platform => {
		:columns => [
			{:id => 110, :name => 'Платформа 1'},
			{:id => 210, :name => 'Платформа 2'},
			{:id => 310, :name => 'Платформа 3'}
		],
		:series => [
			{:id => 1, :name => 'Реклама для каналов', :data => [150, 400, 500]},
			{:id => 2, :name => 'Colins Collection', :data => [300, 300, 400]},
			{:id => 5, :name => 'Ipad Ad', :data => [450, 185, 345]}
		]
	},

	:vendor => {
		:columns => [
			{:id => 7, :name => 'Sony'},
			{:id => 8, :name => 'BMW'},
			{:id => 9, :name => 'Apple'},
			{:id => 10, :name => 'Samsung'}
		],
		:series => [
			{:id => 1, :name => 'Реклама для каналов', :data => [400, 500, 200, 100]},
			{:id => 2, :name => 'Colins Collection', :data => [300, 400, 300, 500]},
			{:id => 5, :name => 'Ipad Ad', :data => [185, 345, 440, 435]}
		]

	}
}
def get_stats(category, type)
	if category.to_sym == :common
		$stats[category.to_sym][type.to_sym]
	else
		$stats[category.to_sym]
	end
end

get '/stats' do
	# Пока игнорируем
	section = params[:section]
	category = params[:category]
	type = params[:type]

	content_type :json
	get_stats(category, type).to_json
end