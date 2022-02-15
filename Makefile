### Makefile ###
# Use `make` or `make build` to build all models.
# Use `make parts_only` to only build parts.
# Use `make demos_only` to only build demos.
# Use `make clean` to clean-up and remove all models from the build folder.
# Use `make <filename>.stl` to compile any SCAD file into STL.

### Settings
# Path to OpenSCAD (use `openscad` if in PATH)
OSCAD=C:\Program Files\OpenSCAD\openscad
# Folder containing all SCAD files
SOURCE_FOLDER=src
# Folder receiving all STL files
BUILD_FOLDER=build
# STL Format
# Use 'asciistl' for legacy ASCII STL's instead of binary ('binstl')
STL_FORMAT=binstl

### Rules
# Default rule
# Builds all parts and demos
build: parts_only demo_only

# Only build parts
parts_only: 0-way.stl 1-way.stl 2-way.stl 3-way.stl 4-way.stl 5-way.stl resevoir.stl tray.stl tube_with_hole.stl cover.stl 

# Only build demos
demo_only: demo_all.stl demo_assembled.stl demo_planter.stl demo_tray.stl demo_xways.stl planter.stl

# Creates build folder
$(BUILD_FOLDER):
	mkdir $(BUILD_FOLDER)

# Compiles SCAD (OpenSCAD) files into STL
%.stl: $(SOURCE_FOLDER)/%.scad $(BUILD_FOLDER)
	$(OSCAD) \
		--export-format $(STL_FORMAT) \
		--D $$fn=100 \
		-o $(BUILD_FOLDER)/$@ \
		$<

# Removes all STL files (i.e. build folder)
clean:
	rm -r $(BUILD_FOLDER)
