import info from debug
import insert from 

getfunction = (tbl_info, tbl) ->
	tbl or= getgc!
	for idx, fn in pairs tbl
		if (type fn) == "function"
			if tbl_info.Name ~= nil
				if (info fn, "n") ~= tbl_info.Name
					continue

			if tbl_info.IgnoreSyn == true
				if is_synapse_function fn
					continue

			if tbl_info.Constants ~= nil
				valid = true
				for const in *tbl_info.constants
					const_found = false
					for const_2 in *getconstants fn
						if const_2 == const
							const_found = true
							break
					valid = const_found
					if valid == false
						break
				if valid == false
					continue
			
			return fn


getfunctions = (tbl_info, tbl) ->
	fn_tbl = {}
	tbl or= getgc!
	for idx, fn in pairs tbl
		if (type fn) == "function"
			if tbl_info.Name ~= nil
				if (info fn, "n") ~= tbl_info.Name
					continue

			if tbl_info.IgnoreSyn == true
				if is_synapse_function fn
					continue

			if tbl_info.Constants ~= nil
				valid = true
				for const in *tbl_info.constants
					const_found = false
					for const_2 in *getconstants fn
						if const_2 == const
							const_found = true
							break
					valid = const_found
					if valid == false
						break
				if valid == false
					continue
			
			insert fn_tbl, fn

	fn_tbl
