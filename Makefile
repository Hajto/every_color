install:
	mix deps.get
	cd ./web/static && yarn && cd ../../

build:
	cd ./web/static && npm run build && cd ../../
	rm -rf ./priv/static/
	mv ./web/static/build/ ./priv/static/
