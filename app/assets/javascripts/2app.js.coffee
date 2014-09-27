$(document).ready(() ->
	window.songs_arr = JSON.parse($('#data-songs').html().replace(/&quot;/g,'"'))

	_.templateSettings.interpolate = /\{{3}([\s\S]+?)\}{3}/;
	_.templateSettings.escape = /\{\{([^\{\}]+?)(?!\}\}\})\}\}/;

	Song_model = Backbone.Model.extend({
		defaults: 
			name: ""
			artist: ""
			duration: ""
			score: 0
		})

	Songs_collection = Backbone.Collection.extend({
		model: Song_model
		})

	window.songs_collection = new Songs_collection(songs_arr)

	Song_view = Backbone.View.extend({

		el: '.song-list'

		initialize: () ->
			@list_div = @$el.find('.song-list-container')
			@render()
		
		render: () ->
			songs_collection.each (song) =>
				@list_div.append @song_template(song.toJSON())

		clear_list: () ->
			@list_div.html('')

		song_template: _.template($('#song-template').html())

	})

	window.song_view = new Song_view()
)
