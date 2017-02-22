WINDOW = {
	TITLE = "Pong (Lua; Love2D)",
	WIDTH = 800,
	HEIGHT = 600
}

function love.conf(t)
	t.window.width = WINDOW.WIDTH
	t.window.height = WINDOW.HEIGHT
	t.title = WINDOW.TITLE
	t.window.resizable = false
end