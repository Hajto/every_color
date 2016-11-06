subrepo:
	git submodule update --init --recursive

install:
	mix deps.get
	cd ./front && yarn && cd ../

build:
	cd ./front && yarn build && cd ../
	rm -rf ./priv/static/
	mv ./front/build/ ./priv/static/
