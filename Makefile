
	IMAGE = stackengine/oel_buildbox:1.0.7

build:
	docker build --tag=$(IMAGE) .
	echo TODO: docker login
	echo TODO: docker push $(IMAGE)

