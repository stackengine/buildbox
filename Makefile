IMAGE=stackengine/buildbox:1.0.18

build:
	docker build --tag=$(IMAGE) .
	echo TODO: docker login
	echo TODO: docker push $(IMAGE)

