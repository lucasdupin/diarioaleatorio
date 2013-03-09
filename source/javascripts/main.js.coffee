$ ->
	# Images in a random order
	images = window.shuffle(window.images)
	currentImage = 0


	# Reload on page click
	$('.refresh').click =>
		if ++currentImage >= images.length
			currentImage = 0
		
		image = images[currentImage]
		color = if image.indexOf('white') >= 0 then "white" else "black"
		position = if image.indexOf('left') >= 0 then "left" else "right"

		# Move logo and refresh button
		$('.content').removeClass('white').removeClass('black').removeClass('left').removeClass('right')
		$('.content').addClass(position).addClass(color)

		# update the image
		$('.bg').animate {opacity: 0}, =>
			$('.bg').unbind 'load'
			$('.bg').attr('src', "./images/#{image}")
			# Setup image animation
			$('.bg').bind 'load', ->
				$(window).resize()
				$(@).animate opacity:1
				# console.log "load", $(@).attr('src')

	# Show first picture
	$('.refresh').click()

	# Resize image whe the window size changes
	$(window).resize ->
		bW = $('.bg').width()
		bH = $('.bg').height()
		wW = $(window).width()
		wH = $(window).height()

		if bW / bH > wW / wH
			$('.bg').css width: 'auto', height: wH
		else
			$('.bg').css width: wW, height: 'auto'

		# Centralize image
		$('.bg').css marginLeft: -$('.bg').width()/2, marginTop: -$('.bg').height()/2

	$(window).resize()


window.shuffle = (array)->
	for i in [0...array.length] by 1
		j = Math.floor(Math.random() * (i + 1));
		tmp = array[i]
		array[i] = array[j]
		array[j] = tmp
	array