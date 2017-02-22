color = {
	black = { 0, 0, 0 },
	white = { 255, 255, 255 }
}

board = {}

one = {
	x, y,
	width, height,
	speed,
	color,
	score = 0
}

two = {
	x, y,
	width, height,
	speed,
	color,
	score = 0
}

ball = {
	x,
	y,
	size = 20,
	color,
	speed = { x, y }
}

board.draw = function()
	love.graphics.setColor(color.white)
	love.graphics.line(WINDOW.WIDTH / 2, 0, WINDOW.WIDTH / 2, WINDOW.HEIGHT)
	love.graphics.print("P1: " .. one.score, 10, 10)
	love.graphics.print("P2: " .. two.score, WINDOW.WIDTH - (WINDOW.WIDTH / 18), 10)
end

board.background = function()
	love.graphics.setBackgroundColor(color.black)
end

board.pauseOverlay = function()
	love.graphics.setColor(0, 0, 0, 100)
	love.graphics.rectangle('fill', 0, 0, WINDOW.WIDTH, WINDOW.HEIGHT)
end

one.init = function()
	one.width = WINDOW.WIDTH / 42
	one.height = WINDOW.HEIGHT / 6
	one.x = 0
	one.y = (WINDOW.HEIGHT / 2) - (one.height / 2)
	one.speed = 300
	one.color = color.white
end

one.update = function(dt)
	if love.keyboard.isDown('w') then
		one.y = one.y - (one.speed * dt)
	end
	if love.keyboard.isDown('s') then
		one.y = one.y + (one.speed * dt)
	end

	if one.y < 0 then
		one.y = 0
	elseif (one.y + one.height) > WINDOW.HEIGHT then
		one.y = WINDOW.HEIGHT - one.height
	end
end

one.draw = function()
	love.graphics.setColor(one.color)
	love.graphics.rectangle('fill', one.x, one.y, one.width, one.height)
end

one.collide = function()
	if ball.x <= one.width and
		(ball.y + ball.size) >= one.y and
		ball.y < (one.y + one.height)
	then
		ball.speed.x = math.abs(ball.speed.x)
	end
end

two.init = function()
	two.width = WINDOW.WIDTH / 42
	two.height = WINDOW.HEIGHT / 6
	two.x = WINDOW.WIDTH - two.width
	two.y = (WINDOW.HEIGHT / 2) - (two.height / 2)
	two.speed = 300
	two.color = color.white
end

two.update = function(dt)
	if love.keyboard.isDown('up') then
		two.y = two.y - (two.speed * dt)
	end
	if love.keyboard.isDown('down') then
		two.y = two.y + (two.speed * dt)
	end

	if two.y < 0 then
		two.y = 0
	elseif (two.y + two.height) > WINDOW.HEIGHT then
		two.y = WINDOW.HEIGHT - two.height
	end
end

two.draw = function()
	love.graphics.setColor(two.color)
	love.graphics.rectangle('fill', two.x, two.y, two.width, two.height)
end

two.collide = function()
	if (ball.x + ball.size) >= (WINDOW.WIDTH - two.width) and
		(ball.y + ball.size) >= two.y and
		ball.y < (two.y + two.height)
	then
		ball.speed.x = -math.abs(ball.speed.x)
	end
end

ball.init = function(start_height)
	rand = math.random(0, 1)
	if(rand >= 0.5) then
		ball.speed.x = (-350)
		rand = math.random(0, 1)
		if(rand >= 0.5) then
			ball.speed.y = (-350)
		else
			ball.speed.y = 350
		end
	else
		ball.speed.x = 350
		if(rand >= 0.5) then
			ball.speed.y = (-350)
		else
			ball.speed.y = 350
		end
	end
	ball.x = (WINDOW.WIDTH / 2) - (ball.size / 2)
	ball.y = start_height
	ball.color = color.white
end

ball.collide = function()
	if ball.y < 0 then ball.speed.y = math.abs(ball.speed.y) end
	if(ball.y + ball.size) > WINDOW.HEIGHT then ball.speed.y = -math.abs(ball.speed.y) end
end

ball.bounce = function()
	ball.collide()
	one.collide()
	two.collide()
end

ball.update = function(dt)
	ball.x = ball.x + (ball.speed.x * dt)
	ball.y = ball.y + (ball.speed.y * dt)
end

ball.draw = function()
	love.graphics.setColor(ball.color)
	love.graphics.rectangle('fill', ball.x, ball.y, ball.size, ball.size)
end

ball.reset = function()
	start_height = math.random(0, WINDOW.HEIGHT)
	if ball.x + ball.size < 0 then
		two.score = two.score + 1
		ball.init(start_height)
	elseif ball.x > WINDOW.WIDTH then
		one.score = one.score + 1
		ball.init(start_height)
	end
end