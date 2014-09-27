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
			@bind_votes()
		
		render: () ->
			songs_collection.each (song) =>
				@list_div.append @song_template(song.toJSON())

		bind_votes: (e) ->
			$('.post-vote').bind('click', (e) =>
				if $(e.currentTarget).hasClass('upvote')
					id = $(e.currentTarget).data('songId')
					url = "/api/radio/upvote_song/#{id}"
					$.ajax
						type: 'POST'
						url: url
						success: (res) =>
							if res.text is "Already Voted"
								@$el.find(".post-vote[data-song-id=\"#{res.id}\"]").hide()

				else if $(e.currentTarget).hasClass('downvote')
					id = $(e.currentTarget).data('songId')
					url = "/api/radio/downvote_song/#{id}"
					$.ajax
						type: 'POST'
						url: url
						success: (res) =>
							if res.text is "Already Voted"
								@$el.find(".post-vote[data-song-id=\"#{res.id}\"]").hide()

				)

		clear_list: () ->
			@list_div.html('')

		song_template: _.template($('#song-template').html())

	})

	window.song_view = new Song_view()
)
