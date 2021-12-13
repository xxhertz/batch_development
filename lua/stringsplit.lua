function string.split(str, delim)
	delim = delim or "%s"

	local matches = {}
	for str in string.gmatch(str, "([^"..delim.."]+)") do
		table.insert(matches, str)
	end
	return matches
end
