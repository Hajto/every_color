install:
	mix deps.get
	cd ./web/static && npm install && cd ../../

build:
	cd ./web/static && npm run build && cd ../../
	rm -rf ./priv/static
	mkdir ./priv/static
	cp -r ./web/static/build/ ./priv/static
