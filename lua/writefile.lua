function writefile(name, content)
	local file = io.open(name, "w+")
	io.output(file)
	io.write(content)
	io.flush()
	io.close(file)
end

function readfile(name)
	local file = io.open(name, "rb")
	io.output(file)
	local content = file:read("*all")
	io.flush()
	io.close(file)
	return content
end

function appendfile(name, content)
	local file = io.open(name, "a")
	io.output(file)
	io.write(content)
	io.flush()
	io.close(file)
end
