require 'graphics'

function love.load()
	math.randomseed(os.time())
	one.init()
	two.init()
	ball.init((WINDOW.HEIGHT / 2) - (ball.size / 2))

	state = 'pause'
end

function love.update(dt)
	if state ~= 'play' then return end

	one.update(dt)
	two.update(dt)
	ball.bounce()
	ball.reset()
	ball.update(dt)
end

function love.draw()
	board.background()
	board.draw()
	one.draw()
	two.draw()
	ball.draw()

	if state == 'pause' then board.pauseOverlay() end
end

function love.keypressed(key)
	if key == 'p' then
		state = (state == 'play' and 'pause' or 'play')
	elseif key == 'escape' then
		os.exit()
	end

	if state == 'pause' then
		if key == 'w' or key == 's' or key == 'up' or key == 'down' then
			state = 'play'
		end
	end
end
