IMAGE=stackengine/buildbox:1.0.15

build:
	docker build --tag=$(IMAGE) .
	echo TODO: docker login
	echo TODO: docker push $(IMAGE)

