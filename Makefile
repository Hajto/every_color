install:
	mix deps.get
	cd ./web/static && npm install && cd ../../

build:
	cd ./web/static && npm run build && cd ../../
	mv ./web/static/build/ ./priv/static/
