SRC = src
BUILD = build
HTML = example/index.html

build: test build-directory html js

build-directory:
	mkdir -p $(BUILD)

html:
	cp $(HTML) $(BUILD)/index.html

js:
	elm-make example/App.elm --output $(BUILD)/app.js

start:
	cd build;python -m SimpleHTTPServer 8000

test:
	cd tests && elm-test Main.elm
