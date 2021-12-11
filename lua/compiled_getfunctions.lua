local info
info = debug.info
local insert
insert = table.insert
local getfunction
getfunction = function(tbl_info, tbl)
	tbl = tbl or getgc()
	for idx, fn in pairs(tbl) do
		local _continue_0 = false
		repeat
			if (type(fn)) == "function" then
				if tbl_info.Name ~= nil then
					if (info(fn, "n")) ~= tbl_info.Name then
						_continue_0 = true
						break
					end
				end
				if tbl_info.IgnoreSyn == true then
					if is_synapse_function(fn) then
						_continue_0 = true
						break
					end
				end
				if tbl_info.Constants ~= nil then
					local valid = true
					local _list_0 = tbl_info.constants
					for _index_0 = 1, #_list_0 do
						local const = _list_0[_index_0]
						local const_found = false
						local _list_1 = getconstants(fn)
						for _index_1 = 1, #_list_1 do
							local const_2 = _list_1[_index_1]
							if const_2 == const then
								const_found = true
								break
							end
						end
						valid = const_found
						if valid == false then
							break
						end
					end
					if valid == false then
						_continue_0 = true
						break
					end
				end
				return fn
			end
			_continue_0 = true
		until true
		if not _continue_0 then
			break
		end
	end
end
local getfunctions
getfunctions = function(tbl_info, tbl)
	local fn_tbl = { }
	tbl = tbl or getgc()
	for idx, fn in pairs(tbl) do
		local _continue_0 = false
		repeat
			if (type(fn)) == "function" then
				if tbl_info.Name ~= nil then
					if (info(fn, "n")) ~= tbl_info.Name then
						_continue_0 = true
						break
					end
				end
				if tbl_info.IgnoreSyn == true then
					if is_synapse_function(fn) then
						_continue_0 = true
						break
					end
				end
				if tbl_info.Constants ~= nil then
					local valid = true
					local _list_0 = tbl_info.constants
					for _index_0 = 1, #_list_0 do
						local const = _list_0[_index_0]
						local const_found = false
						local _list_1 = getconstants(fn)
						for _index_1 = 1, #_list_1 do
							local const_2 = _list_1[_index_1]
							if const_2 == const then
								const_found = true
								break
							end
						end
						valid = const_found
						if valid == false then
							break
						end
					end
					if valid == false then
						_continue_0 = true
						break
					end
				end
				insert(fn_tbl, fn)
			end
			_continue_0 = true
		until true
		if not _continue_0 then
			break
		end
	end
	return fn_tbl
end
