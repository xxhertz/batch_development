import os, subprocess, time

output_directory = "."

if os.path.exists("output_dir.txt"):
	with open("output_dir.txt", "r") as f:
		output_directory = f.read()

def compile_moon(filename):
	lua_name = filename.removesuffix(".moon") + ".lua"
	try:
		subprocess.run(["moonscript\\moonc.exe", "-t", "moonout",  f"src\\{filename}"])
		os.replace(f".\\moonout\\src\\{lua_name}", f".\\moonout\\{lua_name}")
		os.removedirs(".\\moonout\\src\\")
	except:
		print(f"failed to parse {filename}")


def bundle_files():
	os.system('coffee tape -m main -o "final_build.lua" -d .\\moonout .')
	os.replace(".\\final_build.lua", f"{output_directory}\\final_build.lua")

if os.path.exists(".\\moonscript\\") == False or os.path.exists(".\\moonscript\\moonc.exe") == False:
	raise Exception("moonscript folder not found; please put moonc.exe from the moonscript github in a folder called 'moonscript'")

if os.path.exists(".\\src\\") == False:
	os.mkdir(".\\src\\")

if os.path.exists(".\\moonout\\") == False:
	os.mkdir(".\\moonout\\")

old_date = {}

while True:
	for f in os.listdir("./src/"):
		if f.endswith(".moon"):
			current_date = os.stat(f"./src/{f}").st_mtime
			if old_date.get(f) != current_date:
				old_date[f] = current_date
				compile_moon(f)
				bundle_files()
	
	time.sleep(0.5)
